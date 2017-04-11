# Project: Event Manager in Ruby for The Odin Project
# Author: Luján Fernaud
# URL: http://tutorials.jumpstartlab.com/projects/eventmanager.html

system "clear" or "cls"
puts "Event Manager initialized.\n\n"

lines = File.readlines("event_attendees.csv")
lines.each.with_index do |line, index|
  next if index.zero?
  columns = line.split(",")
  name = columns[2]
  puts name
end
