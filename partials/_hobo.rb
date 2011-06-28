# Set up default haml layout

puts "Running Hobo Wizard ...".magenta

run "cd .."
run "#{@rvm} exec hobo g setup_wizard"

puts "\n"

