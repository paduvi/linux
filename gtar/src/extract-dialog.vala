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

public class ExtractDialog : FileChooserDialog {

      private CheckButton overwrite_file;
      private CheckButton keep_directory;

      private RadioButton all_files;
      private RadioButton selected_files;
      private RadioButton listed_files;
      private Entry file_pattern;
        
      public ExtractDialog(Window? window, int type) {
            this.title = "Choose extract location";
            this.action = FileChooserAction.SELECT_FOLDER;
            
            this.set_transient_for(window);
            
            var builder = new Builder();
            try {
                builder.add_from_file ("ui/extra.ui");
            }
            /* Handle the exception */
            catch (Error e) {
                error ("Unable to load file: %s", e.message);
            }
            
            var option_box = builder.get_object("extra_widgets") as Box;
            var content = get_content_area() as Box;            
            
            content.pack_start(option_box, false, true, 10);
            
            this.add_button("Cancel", ResponseType.CANCEL);
            this.add_button("Extract", ResponseType.ACCEPT);
            
            /* load checkboxes and radio buttons */
            all_files = builder.get_object("all_files") as RadioButton;
            selected_files = builder.get_object("selected_files") as RadioButton;
            listed_files = builder.get_object("file_pattern") as RadioButton;
            
            overwrite_file = builder.get_object("overwrite_files") as CheckButton;
            keep_directory = builder.get_object("keep_structure") as CheckButton;     
            
            file_pattern = builder.get_object("file_pattern_entry") as Entry;       
            
            /* set radio button group */
            unowned SList<RadioButton> group = all_files.get_group();
            selected_files.set_group(group);
            listed_files.set_group(group);            
            
            switch (type) {
                case 0: 
                        all_files.set_active(true);
                        break;
                case 1: selected_files.set_active(true);
                        break;
                case 2: listed_files.set_active(true);
                        break;
            }            
      }  
      
      public bool keep_structure() {
            return keep_directory.get_active();
      }

      public bool keep_old_files() {
            return overwrite_file.get_active();
      }  
      
      public string get_pattern() {
            return file_pattern.get_text();
      }
      
      public int get_extract_option() {
            if (selected_files.get_active()) return 1;
            if (listed_files.get_active()) return 2;
            
            return 0;
      }
}