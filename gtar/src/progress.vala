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

public class ProgressWindow : Window {
    
    private Label action_label;
    private Label message_label;
    private ProgressBar progress;
    
    private Button btn_cancel;
    private Button btn_show_files;
    private Button btn_quit;
    
    private int counter;    
    private bool keep_structrue;
    private bool keep_old_files;
    
    private string tar_name;
    private string destination;
    private string[] extract_list;   
    
    private Pid child_pid;
    
    private int file_counts;         
    
    public ProgressWindow(string file_name, string[] extract_list, string destination, bool keep_structure, bool keep_old_files) {
            this.title = "Extracting " + file_name;
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
            btn_show_files.clicked.connect(this.show_files);            
            
            this.extract_list = extract_list;
            this.tar_name = file_name;
            this.destination = destination;
            this.keep_old_files = keep_old_files;
            this.keep_structrue = keep_structure;
                       
            counter = 0;
            this.show_all();
            
            btn_quit.set_visible(false);
            btn_show_files.set_visible(false);
            //action_label.set_line_wrap(false);
            action_label.set_vexpand(false);
            
            file_counts = (extract_list.length > 0) ? extract_list.length : file_counter;
            
            extract();
    }
    
    private void extract() {
        try {
            int extra_args = 0;
            if (keep_old_files) extra_args++;
            if (keep_structrue) extra_args++;
            
            string[] spawn_args = new string[8 + extract_list.length + extra_args];
	    spawn_args[0] = "tar";
    	    spawn_args[1] = "-C";
    	    spawn_args[2] = destination;
    	    spawn_args[3] = "-xvf";
    	    spawn_args[4] = tar_name;
	    
	    int i = 0;
	    for (; i < extract_list.length; i++)
	        spawn_args[i + 5] = extract_list[i];
	    
	    i += 5;
	    spawn_args[i++] = "--checkpoint=1000";
	    spawn_args[i++] = "--checkpoint-action=totals";
	    spawn_args[i++] = "--totals";
	    
	    if (keep_old_files) spawn_args[i++] = "--skip-old-files";
	    if (keep_structrue) spawn_args[i++] = """--transform=s/.*\///""";
	    
	    string[] spawn_env = Environ.get ();	    	
	    int standard_error;
	    int standard_out;

	    Process.spawn_async_with_pipes ("/",
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
        	            btn_show_files.set_visible(true);
	    });

        } catch (SpawnError e) {
	        action_label.label = "Error extracting file: " + e.message;
        }            
            
    }
    
    /* handle output pipe */
    private bool process_line (IOChannel channel, IOCondition condition, string stream_name) {            
	    if (condition == IOCondition.HUP) {
		    //stdout.printf ("%s: The fd has been closed.\n", stream_name);
		    action_label.label = "Extraction completed";
		    return false;
	    }

	    try {
		    string line;
		    channel.read_line (out line, null, null);
                    action_label.label = "Extracting: " + line.substring(0, line.length - 1);
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
    
    private void show_files() {
            try {
	        string[] spawn_args = {"xdg-open", destination};
	        string[] spawn_env = Environ.get ();
	        Pid child_pid;	

	        Process.spawn_async ("/",
		        spawn_args,
		        spawn_env,
		        SpawnFlags.SEARCH_PATH,
		        null,
		        out child_pid);
		        		
            } catch (SpawnError e) {
	            stdout.printf("Error extracting file: " + e.message);
            }
            
            this.close();
    }
    
    private void cancel() {
        Posix.kill(child_pid, Posix.SIGTERM);
        this.close();    
    }

}