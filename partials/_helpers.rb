puts "Adding helpers, shared views, and other miscellany ...".magenta

copy_static_file 'app/controllers/application_controller.rb'
copy_static_file 'app/helpers/application_helper.rb'
copy_static_file 'app/views/shared/_error_messages.html.haml'
copy_static_file 'config/initializers/sass_config.rb'

#Patch for paperclip hash
copy_static_file 'config/initializers/99_paperclip_hash_patch.rb'

# Get the latest version of the Jquery version of rails.js
#download_file "https://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

if File.directory?('.git') then
  git :add => '.'
  git :commit => "-aqm 'Added helpers, shared views, and other miscellany.'"
end

puts "\n"

