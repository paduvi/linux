/* Copyright 2015 taprosoft
*
* This file is part of Gtar.
*
* Gtar is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* Gtar is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Gtar. If not, see http://www.gnu.org/licenses/.
*/

using Gtk;

public class AddProgressWindow : Window {
    
    private Label action_label;
    private Label message_label;
    private ProgressBar progress;
    
    private Button btn_cancel;
    private Button btn_show_files;
    private Button btn_quit;
    
    private int counter;    
    private bool update;
    private string current_folder;
    private string exclude;
    
    private Pid child_pid;	
    
    private string tar_name;
    private unowned SList<string> add_list;   
    
    private uint file_counts;         
    
    public AddProgressWindow(string file_name, SList<string> add_list, string current_folder, bool update, string exclude) {
            this.title = "Adding files to " + file_name;
            this.window_position = WindowPosition.CENTER;    
            
            /* set app icon */
            try {
                this.icon = new Gdk.Pixbuf.from_file("tar.ico");
            } catch (Error e) {
                stderr.printf ("Could not load application icon: %s\n", e.message);
            }
            
            var builder = new Builder();
            try {
                builder.add_from_file ("ui/progress.ui");
            }
            /* Handle the exception */
            catch (Error e) {
                error ("Unable to load file: %s", e.message);
            }
            
            var vbox = builder.get_object("main_box") as Box;
            add(vbox);            
            action_label = builder.get_object("action_label") as Label;
            message_label = builder.get_object("message_label") as Label;
            progress = builder.get_object("progress_progressbar") as ProgressBar;            
            
            btn_cancel = builder.get_object("btn_cancel") as Button;                        
            btn_quit = builder.get_object("btn_quit") as Button;
            btn_show_files = builder.get_object("btn_show_files") as Button;
            
            btn_cancel.clicked.connect(cancel);
            btn_quit.clicked.connect(Gtk.main_quit);                    
            
            this.tar_name = file_name;
            this.add_list = add_list;
            this.current_folder = current_folder;
            this.update = update;
            this.exclude = exclude;
                       
            counter = 0;
            this.show_all();
            
            btn_quit.set_visible(false);
            btn_show_files.set_visible(false);
            action_label.set_vexpand(false);
            
            file_counts = add_list.length();
            
            add_file();
    }
    
    private void add_file() {
        try {            
            string[] spawn_args = new string[7 + file_counts];
	    spawn_args[0] = "tar";
    	    spawn_args[1] = update ? "-uvf" : "-rvf";
    	    spawn_args[2] = tar_name;
	    
	    int i = 0;
	    int len = current_folder.length;
	    for (; i < file_counts; i++) 
	        spawn_args[i + 3] = add_list.nth(i).data.substring(len + 1);
	    
	    i += 3;
	    spawn_args[i++] = "--exclude=" + exclude; 
	    spawn_args[i++] = "--checkpoint=1000";
	    spawn_args[i++] = "--checkpoint-action=totals";
	    spawn_args[i++] = "--totals";	    
	    
	    string[] spawn_env = Environ.get ();	    
	    int standard_error;
	    int standard_out;

	    Process.spawn_async_with_pipes (current_folder,
		    spawn_args,
		    spawn_env,
		    SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
		    null,
		    out child_pid,
		    null,
		    out standard_out,
		    out standard_error);
		
	    // stdout:
	    IOChannel output = new IOChannel.unix_new (standard_out);
	    output.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
		    return this.process_line (channel, condition, "stdout");
	    });		
		
	    // stderr:
	    IOChannel error = new IOChannel.unix_new (standard_error);
	    error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
		    return this.process_error (channel, condition, "stderr");
	    });
		
            ChildWatch.add (child_pid, (pid, status) => {
			    // Triggered when the child indicated by child_pid exits			
			    Process.close_pid (pid);
			    btn_cancel.set_label("Close");
			    btn_quit.set_visible(true);
			    open_file(tar_name);
	    });

        } catch (SpawnError e) {
	        action_label.label = "Error adding file: " + e.message;
        }            
            
    }
    
    /* handle output pipe */
    private bool process_line (IOChannel channel, IOCondition condition, string stream_name) {            
	    if (condition == IOCondition.HUP) {
		    //stdout.printf ("%s: The fd has been closed.\n", stream_name);
		    action_label.label = "Adding files completed";
		    return false;
	    }

	    try {
		    string line;
		    channel.read_line (out line, null, null);
                    action_label.label = "Adding: " + line.substring(0, line.length - 1);
                    counter++;
                    progress.set_fraction( 1.0f * counter / file_counts);
                    
	    } catch (IOChannelError e) {
		    stdout.printf ("%s: IOChannelError: %s\n", stream_name, e.message);
		    return false;
	    } catch (ConvertError e) {
		    stdout.printf ("%s: ConvertError: %s\n", stream_name, e.message);
		    return false;
	    }

	    return true;
    }

    private bool process_error(IOChannel channel, IOCondition condition, string stream_name) {            
            if (condition == IOCondition.HUP) {
		    return false;
	    }
	
	    try {
		    string line;
		    channel.read_line (out line, null, null);
                    message_label.label = line.substring(0, line.length - 1);
                    
	    } catch (IOChannelError e) {
		    stdout.printf ("%s: IOChannelError: %s\n", stream_name, e.message);
		    return false;
	    } catch (ConvertError e) {
		    stdout.printf ("%s: ConvertError: %s\n", stream_name, e.message);
		    return false;
	    }
	
            return true;
    }
    
    private void cancel() {
        Posix.kill(child_pid, Posix.SIGTERM);
        this.close();    
    }

}