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

public class FileViewer : Window {

    private TextView text_view;

    public FileViewer (string filename) {
        this.title = "Content of "+ filename;
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

        var scroll = new ScrolledWindow (null, null);
        scroll.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scroll.add (this.text_view);
                
        var btn_close = new Button.with_label("Close");
        btn_close.clicked.connect(this.close);

        var vbox = new Box (Orientation.VERTICAL, 0);
        vbox.pack_start (scroll, true, true, 0);
        vbox.pack_start(btn_close, false, false);
        add (vbox);
        
        open_file(filename);
    }

    private void open_file (string filename) {
        try {
            string text;
            FileUtils.get_contents (filename, out text);
            this.text_view.buffer.text = text;
        } catch (Error e) {
            stderr.printf ("Error: %s\n", e.message);
        }
    }
}
