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

using GLib;
using Gtk;

static Label lbl_hello;
static Window window_main;
static Gtk.Menu main_menu;
static Gtk.Menu popup_menu;
static TreeView tree_view;
static Statusbar status_bar;
static HeaderBar header_bar;
static SearchEntry search_box;
static Gtk.MenuItem view_item;
static Button btn_extract;
static Button btn_add;
static string current_file;

/* init app main menu */
static void init_menu() {
    var builder = new Builder();
    try {
        builder.add_from_file ("ui/menu.ui");
	}
	/* Handle the exception */
	catch (Error e) {
	    error ("Unable to load file: %s", e.message);
	}
    builder.connect_signals (null);
    main_menu = builder.get_object("main_menu") as Gtk.Menu;
    var open_item = builder.get_object("open") as Gtk.MenuItem;
    var about_item = builder.get_object("about") as Gtk.MenuItem;
    open_item.activate.connect (on_open_clicked);
    about_item.activate.connect (on_about_clicked);
    
    popup_menu = builder.get_object("popup_menu") as Gtk.Menu;
    view_item = builder.get_object("view") as Gtk.MenuItem;
    view_item.activate.connect(view_current_select);
    
    var extract_item = builder.get_object("extract") as Gtk.MenuItem;
    var delete_item = builder.get_object("delete") as Gtk.MenuItem;
    var new_item = builder.get_object("new") as Gtk.MenuItem;
    var test_item = builder.get_object("test") as Gtk.MenuItem;
    var properties_item = builder.get_object("properties") as Gtk.MenuItem;
    
    extract_item.activate.connect(() => {show_extract(1);});
    delete_item.activate.connect(on_delete_clicked);
    test_item.activate.connect(on_verify_clicked);
    new_item.activate.connect(on_new_clicked);
    properties_item.activate.connect(() => {if (current_file != null) 
        {var w = new PropertiesWindow(current_file);
            }});
}

/* handle add click event */
static void on_add_clicked() {
    var file_chooser = new FileChooserDialog ("Select files to add", window_main,
                                      FileChooserAction.SELECT_FOLDER,
                                      Stock.CANCEL, ResponseType.CANCEL,
                                      "Add", ResponseType.ACCEPT);
    file_chooser.set_select_multiple(true);    
    var builder = new Builder.from_file("ui/add.ui");
    var vbox = builder.get_object("extra_widget") as Box;
    file_chooser.get_content_area().pack_start(vbox, false, true, 0);
    var update = builder.get_object("update_checkbutton") as CheckButton;    
    var exclude = builder.get_object("exclude_files_entry") as Entry;
    var btn_switch = builder.get_object("btn_switch") as Button;
    
    btn_switch.clicked.connect(() => {
        if (btn_switch.get_label() == "Show Folders") {
            file_chooser.set_action(FileChooserAction.OPEN);
            btn_switch.set_label("Show Files");
        }
        else
        {
            file_chooser.set_action(FileChooserAction.SELECT_FOLDER);
            btn_switch.set_label("Show Folders");
        }
        
    });
    
    if (file_chooser.run () == ResponseType.ACCEPT) {
            if (file_chooser.get_current_folder() != null) {
                string folder = file_chooser.get_current_folder();   
                             
                var progress = new AddProgressWindow(current_file, file_chooser.get_filenames(), folder, update.get_active(), exclude.get_text());
            }
    }    
    
    file_chooser.destroy ();    
}

/* handle new archive click event */
static void on_new_clicked() {
    var file_chooser = new FileChooserDialog ("Create new archive", window_main,
                                      FileChooserAction.SAVE,
                                      Stock.CANCEL, ResponseType.CANCEL,
                                      "Create", ResponseType.ACCEPT);
                                      
    Gtk.FileFilter filter = new Gtk.FileFilter ();
    file_chooser.set_filter (filter);               
    file_chooser.set_do_overwrite_confirmation(true);
    filter.add_pattern("*.tar");

    if (file_chooser.run () == ResponseType.ACCEPT) {
    
        uint context = status_bar.get_context_id("file");
        string file_name = file_chooser.get_filename();
        
        try {
	    string[] spawn_args = {"tar", "-cf", file_name, "-T", "/dev/null"};
	    string[] spawn_env = Environ.get ();
	    Pid child_pid;	
	    int standard_error;

	    Process.spawn_async_with_pipes ("/",
		    spawn_args,
		    spawn_env,
		    SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
		    null,
		    out child_pid,
		    null,
		    null,
		    out standard_error);
		
	    // stderr:
	    IOChannel error = new IOChannel.unix_new (standard_error);
	    error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
		    return process_error (channel, condition, "stderr");
	    });	
		
            ChildWatch.add (child_pid, (pid, status) => {
			    // Triggered when the child indicated by child_pid exits			
			    Process.close_pid (pid);
			    open_file(file_name);
			    });

        } catch (SpawnError e) {
	        status_bar.push(context, "Error extracting file: " + e.message);
        }
            
    }
    
    file_chooser.destroy ();        
}

/* handle open click event */
static void on_open_clicked() {
    var file_chooser = new FileChooserDialog ("Open File", window_main,
                                      FileChooserAction.OPEN,
                                      Stock.CANCEL, ResponseType.CANCEL,
                                      Stock.OPEN, ResponseType.ACCEPT);
                                      
        Gtk.FileFilter filter = new Gtk.FileFilter ();
	file_chooser.set_filter (filter);                                    
	filter.add_pattern("*.tar");
	filter.add_pattern("*.tar.*");
	
	
        if (file_chooser.run () == ResponseType.ACCEPT) {
            open_file(file_chooser.get_filename ());
        }
        file_chooser.destroy ();
}

/* handle about click event */
static void on_about_clicked() {
    string[] authors = {"Tuan Anh Nguyen Dang"};
    Gdk.Pixbuf icon = null;
    try {
        icon = new Gdk.Pixbuf.from_file("tar.ico");
    }
    catch (Error e) {
        stdout.printf("Error loading about icon: %s\n", e.message);
    }
    Gtk.show_about_dialog (window_main,
		"program-name", ("Gtar"),
		"copyright", ("Copyright © 2015 taprosoft"),
		"authors", authors,
		"version", "1.0",
		"comments", "Simple GTK+ front-end for GNU 'tar' command",
		"license_type", License.GPL_3_0,
		"logo", icon
		);

}

/* handle verify click event */
static void on_verify_clicked() {
    if (current_file != null && current_file.length > 0) {
        var window = new VerifyWindow(current_file);
        window.show_all();
    }
}

/* helper function for pretty file size */
static string str_printf(string format, ...) {
    va_list va_list = va_list ();
    return format.vprintf (va_list);
}

static string lceil(float x) {
    return str_printf("%.1f", x);
}

static string pretty_size(string file_size) {
        int size = int.parse(file_size);        
        string output;
         if (size<1024) {output = file_size.to_string() + " B";}
          else if(( size<1048576) && (size>1023) ) {output = lceil(size / 1024f) + " KB";}
            else if(( size<1073741824) && (size>1048575) ) {output = lceil(size/1048576f) + " MB";}
               else{ output=lceil(size/1073741824f) + " GB";}
        return output;        
}

/* set up main tree view */
static void setup_tree(TreeView tree) {

    var store = new TreeStore(9, typeof(string), typeof (Gdk.Pixbuf), typeof(string), typeof(bool),
                                typeof(string), typeof(string), typeof(string), typeof(string), typeof(int));    
    tree_view.set_model(store);
    
    var treeViewCol = new TreeViewColumn();
    var colCellText = new Gtk.CellRendererText();
    var colCellImg = new Gtk.CellRendererPixbuf();
    treeViewCol.pack_start(colCellImg, false);
    treeViewCol.pack_start(colCellText, true);
    treeViewCol.add_attribute(colCellText, "text", 0);
    treeViewCol.add_attribute(colCellImg, "pixbuf", 1);
    tree_view.append_column(treeViewCol);
    treeViewCol.set_title("File name");
    treeViewCol.set_resizable(true);
    
    var att = new CellRendererText ();
    att.@set("font", "monospace", null);
    tree_view.insert_column_with_attributes (-1, "Size", new CellRendererText (), "text", 4, null);
    tree_view.insert_column_with_attributes (-1, "Date Modified", new CellRendererText (), "text", 5, null);    
    tree_view.insert_column_with_attributes (-1, "Owner", new CellRendererText (), "text", 6, null);    
    tree_view.insert_column_with_attributes (-1, "Attributes", att , "text", 7, null);    
    for (int i = 0; i < 4; i++) {
        tree_view.get_column(i + 1).set_reorderable(true);
        tree_view.get_column(i + 1).set_sort_column_id(i + 4);
        tree_view.get_column(i + 1).set_sort_indicator(true);
    }
    tree_view.get_column(0).set_sort_column_id(0);
    tree_view.get_column(0).set_sort_indicator(true);
    tree_view.get_column(1).set_sort_column_id(8);
    
    tree_view.row_activated.connect(on_row_activated);        
    tree_view.button_press_event.connect(show_popup);
    tree_view.get_selection().set_mode(SelectionMode.MULTIPLE);
}

/* view current selected file */
static void view_current_select() {
    var path = tree_view.get_selection().get_selected_rows(null).nth(0).data;
    on_row_activated(path, tree_view.get_column(0));
}

/* row activated event */
static void on_row_activated(TreePath path, TreeViewColumn column) {
    TreeIter it;
    var tree_store = tree_view.get_model() as TreeStore;
    tree_store.get_iter(out it, path);
    Value dir_value = Value(typeof(bool));
    tree_store.get_value(it, 3, out dir_value);
    
    bool isDirectory = (bool) dir_value ;
    if (isDirectory) 
        tree_view.expand_to_path(path);
    else {
        Value path_value = Value(typeof(string));
        tree_store.get_value(it, 2, out path_value);
        string file_path = path_value.get_string();

        uint context = status_bar.get_context_id("file");
        status_bar.push(context, "Extracting '" + file_path + "' ... ");
        extract_file(file_path);        
    }
}

static void on_delete_clicked() {

    Gtk.MessageDialog msg = new Gtk.MessageDialog (window_main, Gtk.DialogFlags.MODAL, Gtk.MessageType.WARNING, Gtk.ButtonsType.OK_CANCEL, "Delete selected file(s) ?");
			msg.response.connect ((response_id) => {
			if (response_id == Gtk.ResponseType.OK) {
                            var store = tree_view.get_model() as TreeStore;        
                            var selection = tree_view.get_selection().get_selected_rows(null);
                            foreach (var path in selection) {
                                    TreeIter it;
                                    store.get_iter(out it, path);
                                    Value path_value = Value(typeof(string));
                                    store.get_value(it, 2, out path_value);
                                    string file_path = path_value.get_string();
                                    
                                    delete_file(file_path);            
                            }
                            for (uint i = selection.length(); i > 0; i--) {
                                        TreeIter iter;
                                        var path = selection.nth(i-1).data;
                                        if (path.compare(new TreePath.from_indices(0)) == 0) continue;
                                        store.get_iter(out iter, path);
                                        store.remove(ref iter);
                            }
			}

			msg.destroy();
		});
    msg.show ();       
}

/* extract single file to /tmp */
static void extract_file(string file_name) {
    //string command = "tar -C /tmp -xvf '" + current_file + "' '" + file_name + "'";
    uint context = status_bar.get_context_id("file");
    try {
	string[] spawn_args = {"tar", "-C", "/tmp", "-xvf", current_file, file_name, "--checkpoint=1000", "--checkpoint-action=totals", "--totals"};
	string[] spawn_env = Environ.get ();
	Pid child_pid;	
	int standard_error;

	Process.spawn_async_with_pipes ("/",
		spawn_args,
		spawn_env,
		SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
		null,
		out child_pid,
		null,
		null,
		out standard_error);
		
	// stderr:
	IOChannel error = new IOChannel.unix_new (standard_error);
	error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
		return process_error (channel, condition, "stderr");
	});	
		
        ChildWatch.add (child_pid, (pid, status) => {
			// Triggered when the child indicated by child_pid exits			
			Process.close_pid (pid);
			
			var view_window = new FileViewer("/tmp/" + file_name);
                        status_bar.pop(context);
                        view_window.show_all();
                        lbl_hello.label = "";
			});

    } catch (SpawnError e) {
	    status_bar.push(context, "Error extracting file: " + e.message);
    }            
}

static void delete_file(string file_name) {
    uint context = status_bar.get_context_id("file");
    try {
	string[] spawn_args = {"tar", "-f", current_file, "--delete", file_name, "--checkpoint=1000", "--checkpoint-action=totals", "--totals"};
	string[] spawn_env = Environ.get ();
	Pid child_pid;	
	int standard_error;

	Process.spawn_async_with_pipes ("/",
		spawn_args,
		spawn_env,
		SpawnFlags.SEARCH_PATH,
		null,
		out child_pid,
		null,
		null,
		out standard_error);
		
	// stderr:
	IOChannel error = new IOChannel.unix_new (standard_error);
	error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
		return process_error (channel, condition, "stderr");
	});	

    } catch (SpawnError e) {
	    status_bar.push(context, "Error deleting file: " + e.message);
    }            
}

/* open file */
static void open_file(string filename) {
    
    header_bar.set_subtitle(filename);
        
    uint context_id = status_bar.get_context_id("open");
    status_bar.push(context_id, "Opening " + filename + " ...");            
    current_file = filename;
    tar_list_async(filename);
    //populate_tree(store, it, filename);   
}

/* populate the tree_view with files */
static void populate_tree(TreeStore tree_store, TreeIter parent) {  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    string[] list = tar_sorted.split("\n");        
    
    int dir_count = 0;
    
    foreach (var item in list) {
        if (item.length == 0) continue;
        
        string[] info = new string[6];
        info[5] = item.split("\"")[1];
        item = item.split("\"")[0];
        
        for (int i = 0 ; i < 4; i++) {
            info[i] = item.split(" ", 0)[0];
            item = item.substring(info[i].length)._strip();   
        }
        info[4] = item._strip();

        string[] name = info[5].split("/");
        if (name.length == 0) continue;
        
        bool isDirectory = (info[5].@get(info[5].length - 1) == '/');
        Gdk.Pixbuf item_icon = null;   
        Gdk.Pixbuf folder_icon = null;   
        
        try {
            item_icon = Gtk.IconTheme.get_default().load_icon(isDirectory ? "folder":"empty", 22, 0);
            folder_icon = Gtk.IconTheme.get_default().load_icon("folder", 22, 0);
            }
        catch (Error e) {
            stdout.printf("Error loading icons: %s\n", e.message);
        }
                
        TreeIter it;
        tree_store.get_iter_first(out it);        // get root iter
        int name_index = isDirectory ? name.length - 2 : name.length - 1;  
        if (isDirectory) dir_count++;                      
                
        for (int i = 0; i < name_index ; i++) {            
            TreeIter child_it;
            if (tree_store.iter_children(out child_it, it)) {
                Value name_value = Value(typeof(string));
                tree_store.get_value(child_it, 0, out name_value);
                string item_name = name_value.get_string();
                while (item_name != name[i] && tree_store.iter_next(ref child_it)) {
                    name_value = Value(typeof(string));
                    tree_store.get_value(child_it, 0, out name_value);
                    item_name = name_value.get_string();
                }    
                if (item_name != name[i]) { 
                    tree_store.append(out child_it, it);
                    tree_store.set(child_it, 0, name[i], 1, folder_icon, 3, true, 8, 0, -1);
                }
                it = child_it;            
            }
            else {
                tree_store.append(out child_it, it);
                tree_store.set(child_it, 0, name[i], 1, folder_icon, 3, true, 8, 0, -1);
                it = child_it;
            }
        }           
        
        string item_name = name[name_index];
        
        tree_store.append(out it, it);    
        
        string size = isDirectory ? "" : pretty_size(info[2]);
        
        tree_store.set(it, 0, item_name, 1, item_icon, 2, info[5], 3, isDirectory,
                           4, size, 5, info[3] + " " + info[4], 6, info[1],
                           7, info[0], 8, int.parse(info[2]),-1);    
          
    }     
    
    tree_view.expand_to_path(new TreePath.from_indices(0));
    
    uint context = status_bar.get_context_id("file");
    status_bar.push(context, (list.length - 1 - dir_count).to_string() + " files, " + dir_count.to_string() + " folders");
}


StringBuilder tar_output;
int file_counter;
string tar_sorted;

/* handle output pipe */
static bool process_line (IOChannel channel, IOCondition condition, string stream_name) {
        uint context = status_bar.get_context_id("file");
        
	if (condition == IOCondition.HUP) {
		//stdout.printf ("%s: The fd has been closed.\n", stream_name);
                status_bar.push(context, "Populating files hierarchy ...");	
		return false;
	}

	try {
		string line;
		channel.read_line (out line, null, null);
                tar_output.append(line);
                file_counter++;
                status_bar.push(context, "Opening " + current_file + " ... " + file_counter.to_string() + " files read");
                
	} catch (IOChannelError e) {
		stdout.printf ("%s: IOChannelError: %s\n", stream_name, e.message);
		return false;
	} catch (ConvertError e) {
		stdout.printf ("%s: ConvertError: %s\n", stream_name, e.message);
		return false;
	}

	return true;
}

static bool process_error(IOChannel channel, IOCondition condition, string stream_name) {
        
        if (condition == IOCondition.HUP) {
		return false;
	}
	
	try {
		string line;
		channel.read_line (out line, null, null);
                lbl_hello.label = line.substring(0, line.length - 1);
                
	} catch (IOChannelError e) {
		stdout.printf ("%s: IOChannelError: %s\n", stream_name, e.message);
		return false;
	} catch (ConvertError e) {
		stdout.printf ("%s: ConvertError: %s\n", stream_name, e.message);
		return false;
	}
	
        return true;
}

/* call tar list archive asynchronously and populate the tree view*/
static void tar_list_async(string filename) {
        uint context = status_bar.get_context_id("file");
        try {
		string[] spawn_args = {"tar", "-tvf", filename, "--quoting-style=c", "--checkpoint=1000", "--checkpoint-action=totals", "--totals"};
		string[] spawn_env = Environ.get ();
		Pid child_pid;

		int standard_input;
		int standard_output;
		int standard_error;
		
		tar_output = new StringBuilder();
		tar_sorted = "";
		file_counter = 0;				

		Process.spawn_async_with_pipes ("/",
			spawn_args,
			spawn_env,
			SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
			null,
			out child_pid,
			out standard_input,
			out standard_output,
			out standard_error);

		// stdout:
		IOChannel output = new IOChannel.unix_new (standard_output);
		output.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			return process_line (channel, condition, "stdout");
		});		
		
		// stderr:
		IOChannel error = new IOChannel.unix_new (standard_error);
		error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			return process_error (channel, condition, "stderr");
		});

		ChildWatch.add (child_pid, (pid, status) => {
			// Triggered when the child indicated by child_pid exits
			Process.close_pid (pid);
			
                        string tar_stderr;
	                int status_sort;
                        try {                                
	                        try {
	                            FileUtils.set_contents("/tmp/gtar_read", tar_output.str);	            
	                        }
	                        catch (FileError e) {
	                            stdout.printf("Error writing to tmp: %s\n", e.message);
	                        }	                        
	                        
		                Process.spawn_command_line_sync ("sort -k 6 /tmp/gtar_read",
						                out tar_sorted,
						                out tar_stderr,
    						                out status_sort);
    					
                                TreeIter it;
                                
                                var store = new TreeStore(9, typeof(string), typeof (Gdk.Pixbuf), typeof(string), typeof(bool),
                                                            typeof(string), typeof(string), typeof(string), typeof(string), typeof(int));  
                                tree_view.set_model(store);
                                store.append(out it, null);
                                Gdk.Pixbuf root_icon = null;
                                try {
                                    root_icon = Gtk.IconTheme.get_default().load_icon("archive", 22, 0);
                                }
                                catch (Error e) {
                                        stdout.printf("Error loading icons: %s\n", e.message);
                                }
                                store.set(it, 0, filename, 1, root_icon, 2, null, 3, true, -1);     
                                populate_tree(store, it);
                                lbl_hello.label = "";		
                                btn_extract.set_sensitive(true);	
                                btn_add.set_sensitive(true);                
						                	        		   
	                } catch (SpawnError e) {
		                status_bar.push(context, "Error calling 'sort': " + e.message);
	                }            			
		});

	} catch (SpawnError e) {
		status_bar.push(context, "Error calling 'tar': " + e.message);
	}
}

static TreeIter current_find;

/* search tree view for key */
static bool search_tree(TreeStore tree_store, TreeIter start, string key, bool ignore_start) {
    Value name_value = Value(typeof(string));
    tree_store.get_value(start, 0, out name_value);
    string file_name = name_value.get_string();
    if (file_name.contains(key) && !ignore_start) {
       TreePath path;
       path = tree_store.get_path(start);
       tree_view.scroll_to_cell(path, null, false, 0, 0);
       tree_view.expand_to_path(path);
       tree_view.get_selection().unselect_all();
       tree_view.get_selection().select_path(path);
       current_find = start;
       return true;
    }
    else {
       TreeIter child_it;
       if (tree_store.iter_children(out child_it, start)) {
            bool found = false;
            do {
                found = search_tree(tree_store, child_it, key, false);
            }
            while (!found && tree_store.iter_next(ref child_it));
            
            if (found) return true;
       }      
   }
    
    return false;
}

/* handle next match signal */
static void search_next() {
    var tree_store = tree_view.get_model() as TreeStore;
    string key = search_box.get_text();

    TreeIter curr = current_find;
    if (search_tree(tree_store, curr, key, true)) return;
    
    bool found = false;
        
    do {
        TreeIter child_it = curr;
        tree_store.iter_next(ref child_it);
        do {
            found = search_tree(tree_store, child_it, key, false);
        }         
        while (tree_store.iter_next(ref child_it) && !found); 
    }
    while (!found && tree_store.iter_parent(out curr, curr));
}

/* handle search start signal */
static void start_search() {
    TreeIter root;
    string key = search_box.get_text();
    if (key.length == 0) return;
    var tree_store = tree_view.get_model() as TreeStore;
    tree_store.get_iter_first(out root);
    search_tree(tree_store, root, key, true);
}

/* toggle search box */
static void toggle_search() {
    search_box.set_visible(!search_box.get_visible());
    if (search_box.get_visible()) search_box.grab_focus_without_selecting();
    search_box.set_text("");
}

/* show popup menu on right click */
static bool show_popup(Gdk.EventButton event) {
    if (event.type == Gdk.EventType.BUTTON_PRESS  &&  event.button == 3) {  
        var selection = tree_view.get_selection();
        TreePath path;
        tree_view.get_path_at_pos((int) event.x, (int) event.y, out path, null, null, null);
        if (!selection.path_is_selected(path)) selection.unselect_all();
        selection.select_path(path);
        view_item.set_sensitive(selection.get_selected_rows(null).length() == 1);
        if (selection.get_selected_rows(null) != null) 
            popup_menu.popup(null, null, null, event != null ? event.button : 0, event.get_time());   
        
        return true;
    }
    
    return false;
}

/* show extract option dialog */
static void show_extract(int type) {
    var extract_dialog = new ExtractDialog(window_main, type);
    if (extract_dialog.run () == ResponseType.ACCEPT) {
        switch (extract_dialog.get_extract_option()) {
            case 0: 
                var progress_window = new ProgressWindow(current_file, {}, extract_dialog.get_filename()
                                                    , extract_dialog.keep_structure(), extract_dialog.keep_old_files());
                break;
            case 1:
                var selected_list = tree_view.get_selection().get_selected_rows(null);                
                string[] file_list = new string[selected_list.length()];
                int i;
                for (i = 0; i < selected_list.length(); i++ ) {
                    var path = selected_list.nth(i).data;
                    if (path.compare(new TreePath.from_indices(0)) == 0) break;
                    var store = tree_view.get_model() as TreeStore;
                    TreeIter it;
                    store.get_iter(out it, path);
                    Value name_value = Value(typeof(string));
                    store.get_value(it, 2, out name_value);                                        
                    file_list[i] = name_value.get_string();
                }
                if (i < selected_list.length()) file_list = {};
                var progress_window = new ProgressWindow(current_file, file_list, extract_dialog.get_filename()
                                                    , extract_dialog.keep_structure(), extract_dialog.keep_old_files());
                break;
            case 2:
                var progress_window = new ProgressWindow(current_file, {"--wildcards", extract_dialog.get_pattern()}, extract_dialog.get_filename()
                                                    , extract_dialog.keep_structure(), extract_dialog.keep_old_files());
                
                break;
        }               
    }
    extract_dialog.destroy ();  
}

static void main (string[] args) {
    Gtk.init (ref args);

    /* set up main window */
    window_main = new Window();
    window_main.title = "Gtar";
    window_main.set_default_size (800, 600);
    window_main.destroy.connect (Gtk.main_quit);
    
    /* set app icon */
    try {
        window_main.icon = new Gdk.Pixbuf.from_file("tar.ico");
    } catch (Error e) {
        stderr.printf ("Could not load application icon: %s\n", e.message);
    }

    /* vertical box containing widgets */
    var vbox_main = new Box (Orientation.VERTICAL, 0);
    
    /* init headerbar for app title and buttons */
    header_bar = new HeaderBar();
    header_bar.set_title("Gtar");      
    header_bar.show_close_button = true;
    window_main.set_titlebar(header_bar);
    
    btn_extract = new Button.with_label("Extract");      
    var  btn_menu = new MenuButton();
    var  btn_open = new Button();
    btn_add = new Button();
    var  btn_find = new ToggleButton();
    
    search_box = new SearchEntry();
    
    var menu_icon = new Image.from_stock("gtk-execute" , IconSize.LARGE_TOOLBAR);
    var open_icon = new Image.from_stock("gtk-open" , IconSize.LARGE_TOOLBAR);
    var find_icon = new Image.from_stock("gtk-find" , IconSize.LARGE_TOOLBAR);
    var add_icon = new Image.from_stock("gtk-add", IconSize.LARGE_TOOLBAR);
    
    init_menu();
    btn_menu.set_popup(main_menu);
    btn_menu.set_image(menu_icon);
    btn_open.set_image(open_icon);
    btn_find.set_image(find_icon);
    btn_add.set_image(add_icon);
    btn_open.set_tooltip_text("Open archive");
    btn_add.set_tooltip_text("Add files to archive");
    
    search_box.search_changed.connect(start_search);
    search_box.next_match.connect(search_next);
    btn_open.clicked.connect(on_open_clicked);
    btn_find.clicked.connect(toggle_search);
    btn_add.clicked.connect(on_add_clicked);
    btn_extract.clicked.connect(() => {show_extract(0);});
    btn_extract.set_sensitive(false);
    btn_add.set_sensitive(false);

    header_bar.pack_start(btn_extract); 
    header_bar.pack_start(btn_add);
    header_bar.pack_end(btn_menu); 
    header_bar.pack_end(btn_open);   
    header_bar.pack_end(btn_find);   

    /* set up main tree view */
    lbl_hello = new Label ("Hello!");    
    lbl_hello.set_xalign(0.2f);
    status_bar = new Statusbar();    
    var status_area = status_bar.get_message_area() as Box;
    status_area.pack_start(lbl_hello);

    vbox_main.pack_start(header_bar, false, true);    
    
    tree_view = new TreeView();
    setup_tree(tree_view);
    
    Gtk.ScrolledWindow scrolled = new Gtk.ScrolledWindow (null, null);		
    scrolled.add(tree_view);
        
    vbox_main.pack_start(search_box, false, false);
    vbox_main.pack_start(scrolled);    
    
    vbox_main.pack_start (lbl_hello, false, true);
    vbox_main.pack_start(status_bar, false, true);

    window_main.add (vbox_main);

    window_main.show_all();
    search_box.set_visible(false);

    Gtk.main();
}
