# Project: Event Manager in Ruby for The Odin Project
# Author: Luján Fernaud
# URL: http://tutorials.jumpstartlab.com/projects/eventmanager.html

require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = 'e179a6973728c4dd3fb1204283aaccb5'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(number)
  number = number.match(/\(?(\d*)\)?.?(\d*).?(\d*)/)[1..-1].join

  case number.length
  when 0..9
    false
  when 10
    number
  when 11 && number[0] == 1
    number[1..-1]
  when 11 && number[0] != 1
    false
  when number.length > 11
    false
  end
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

system 'clear' or 'cls'
puts "Event Manager initialized...\n\n"

contents = CSV.open('event_attendees.csv', headers: true,
                                           header_converters: :symbol)

template_letter = File.read('form_letter.html.erb')
erb_template = ERB.new(template_letter)

contents.each do |row|
  id           = row[0]
  name         = row[:first_name]
  zipcode      = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  legislators  = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  puts "Creating thanks letter for id #{id}..."

  save_thank_you_letters(id, form_letter)
end
