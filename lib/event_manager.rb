# Project: Event Manager in Ruby for The Odin Project
# Author: Luján Fernaud
# URL: http://tutorials.jumpstartlab.com/projects/eventmanager.html

require "csv"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

system "clear" or "cls"
puts "Event Manager initialized.\n\n"

contents = CSV.open("event_attendees.csv", headers: true,
                                           header_converters: :symbol)

contents.each do |row|
  name    = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  puts "#{name} #{zipcode}"
end
