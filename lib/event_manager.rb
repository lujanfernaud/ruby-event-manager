# Project: Event Manager in Ruby for The Odin Project
# Author: Luján Fernaud
# URL: http://tutorials.jumpstartlab.com/projects/eventmanager.html

require "csv"

system "clear" or "cls"
puts "Event Manager initialized.\n\n"

contents = CSV.open("event_attendees.csv", headers: true,
                                           header_converters: :symbol)
contents.each do |row|
  name    = row[:first_name]
  zipcode = row[:zipcode]
  puts "#{name} #{zipcode}"
end
