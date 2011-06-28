# Set up capistrano

puts "Setting up Capistrano ... ".magenta

capify!

# Update deploy.rb !!

if File.directory?('.git') then
  git :add => '.'
  git :commit => "-aqm 'Configured Capistrano.'"
end

puts "\n"