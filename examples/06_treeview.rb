$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'gir_ffi-gtk3'

Gtk.init


#Add window.
win = Gtk::Window.new(:toplevel)
win.resize(640, 480)
GObject.signal_connect(win, "destroy"){ Gtk.main_quit }


#Add treeview.
tv = Gtk::TreeView.new


#Add store.
ls = Gtk::ListStore.new([GObject::TYPE_STRING])
tv.set_model(ls)


#Add column.
lab = Gtk::Label.new("Name")
rend = Gtk::CellRendererText.new

col = Gtk::TreeViewColumn.new
col.set_widget(lab)
col.pack_start(rend, true)
col.add_attribute(rend, "text", 0)

lab.show

tv.append_column(col)


#Add rows.
iter_kasper = ls.append
ls.set_value(iter_kasper, 0, "Kasper")

iter_christina = ls.append
ls.set_value(iter_christina, 0, "Christina")


#Mark the last added row as selected.
tv.selection.select_iter(iter_christina)


#Check if a row is selected by iter.
if tv.selection.iter_is_selected(iter_christina)
  puts "Christina is selected."
else
  puts "Christina is not selected."
end


#Get selected rows.
sel = tv.selection.selected_rows


win.add tv
tv.show

win.show

Gtk.main