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

public class VerifyWindow : Window {
    
    private TextView text_view;
    private ScrolledWindow scroll;
        
    public VerifyWindow(string tar_name) {
    
        this.title = "Verify " + tar_name;
        this.window_position = WindowPosition.CENTER;
        set_default_size (600, 400);

        /* set app icon */
        try {
            this.icon = new Gdk.Pixbuf.from_file("tar.ico");
        } catch (Error e) {
            stderr.printf ("Could not load application icon: %s\n", e.message);
        }

        this.text_view = new TextView ();
        this.text_view.editable = false;
        this.text_view.cursor_visible = false;
        this.text_view.set_margin_left(8);
        this.text_view.set_margin_right(8);
        text_view.set_monospace(true);
        
        scroll = new ScrolledWindow (null, null);
        scroll.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scroll.add (this.text_view);
                
        var btn_close = new Button.with_label("Close");
        btn_close.clicked.connect(this.close);
        
        var vbox = new Box (Orientation.VERTICAL, 0);
        vbox.pack_start (scroll, true, true, 0);
        vbox.pack_start(btn_close, false, false);
        add (vbox);
        
        verify(tar_name);
    }
    
    private void verify(string tar_name) {
        try {
	    string[] spawn_args = {"tar", "tf", tar_name, "--totals"};
	    string[] spawn_env = Environ.get ();
	    Pid child_pid;	
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
			    });

        } catch (SpawnError e) {
	        text_view.buffer.text = "Error calling tar: " + e.message;     
        }
    }
    
     private bool process_line (IOChannel channel, IOCondition condition, string stream_name) {            
	    if (condition == IOCondition.HUP) {
		    text_view.buffer.text += "\nDone. No errors found.";
		    scroll.vadjustment.value = scroll.vadjustment.upper - scroll.vadjustment.page_size;
		    return false;
	    }

	    try {
		    string line;
		    channel.read_line (out line, null, null);
                    text_view.buffer.text += line;   
                    scroll.vadjustment.value = scroll.vadjustment.upper - scroll.vadjustment.page_size;                 
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
                    text_view.buffer.text += line;
                    
	    } catch (IOChannelError e) {
		    stdout.printf ("%s: IOChannelError: %s\n", stream_name, e.message);
		    return false;
	    } catch (ConvertError e) {
		    stdout.printf ("%s: ConvertError: %s\n", stream_name, e.message);
		    return false;
	    }
	
            return true;
    }
    
}