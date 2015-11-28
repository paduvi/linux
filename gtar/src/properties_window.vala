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
using GLib;

public class PropertiesWindow : Window {
        public PropertiesWindow(string file_name) {
            File file = File.new_for_path(file_name);        
            
            var builder = new Builder();
            try {
                builder.add_from_file ("ui/properties.ui");
            }
            /* Handle the exception */
            catch (Error e) {
                error ("Unable to load file: %s", e.message);
            }

            /* set app icon */
            try {
                this.icon = new Gdk.Pixbuf.from_file("tar.ico");
            } catch (Error e) {
                stderr.printf ("Could not load application icon: %s\n", e.message);
            }
                        
            this.title = file_name + " Properties";
            this.window_position = WindowPosition.CENTER;    
            
            try {
            FileInfo info = file.query_info("*", 0);
                                                
            var p_name = builder.get_object("p_name_label") as Label; 
            var p_path = builder.get_object("p_path_label") as Label; 
            var p_type = builder.get_object("p_mime_type_label") as Label; 
            var p_att = builder.get_object("p_att_label") as Label; 
            var p_size = builder.get_object("p_size_label") as Label; 
            var p_files = builder.get_object("p_files_label") as Label; 
            
            p_name.label = info.get_name();
            p_path.label = file.get_path();
            p_type.label = info.get_content_type();
            p_size.label = pretty_size(info.get_size().to_string());
            p_att.label = ( new DateTime.from_timeval_utc(info.get_modification_time()) ).format("%Y-%m-%d %R");
            p_files.label = file_counter.to_string();
            
            }
            catch (Error e) {stderr.printf("Error querying file info: " + e.message);}
            
            var vbox = builder.get_object("prefs_table") as Table;
            add(vbox);
            show_all();
        }
}