$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'gir_ffi-gtk3'

Gtk.init

si = Gtk::StatusIcon.new_from_stock(Gtk::STOCK_NEW)

si.signal_connect("activate") do
  puts "Activated! Now quitting!"
  Gtk.main_quit
end

si.signal_connect("popup-menu") do
  puts "Popup-menu activated!"
  
  menu = Gtk::Menu.new
  
  mi = Gtk::MenuItem.new_with_label("Test!")
  mi.signal_connect("activate") do
    puts "Test-item in menu activated"
  end
  
  menu.append(mi)
  menu.show_all
  
  puts menu.methods.sort
  menu.popup
end

si.signal_connect("scroll-event") do |sicon, scroll_event|
  #Skip smooth which always gets called before the actual event.
  if scroll_event.direction.to_s != "smooth"
    puts "Scroll! (direction: #{scroll_event.direction})"
  end
end

Gtk.main