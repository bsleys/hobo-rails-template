#
# hobo-rails-template
#
# Usage:
#   rails new appname -d mysql -m /path/to/template.rb
#
# Also see http://textmate.rubyforge.org/thor/Thor/Actions.html
#

# Directories for template partials and static files
@template_root = File.expand_path(File.join(File.dirname(__FILE__)))
@partials     = File.join(@template_root, 'partials')
@static_files = File.join(@template_root, 'files')

# Copy a static file from the template into the new application
def copy_static_file(path)
  # puts "Installing #{path}...".magenta
  remove_file path
  file path, File.read(File.join(@static_files, path))
  # puts "\n"
end

require "net/http"
require "net/https"

# From "Suspenders" by thoughtbot
def download_file(uri_string, destination)
  uri = URI.parse(uri_string)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri_string =~ /^https/
  request = Net::HTTP::Get.new(uri.path)
  contents = http.request(request).body
  path = File.join(destination_root, destination)
  File.open(path, "w") { |file| file.write(contents) }
end

#need colored for pretty console output
unless Gem.available?('colored')
  run "gem install colored"
  Gem.refresh
  Gem.activate('colored')
end

require "colored"

copy_static_file 'Gemfile'
#apply "#{@partials}/_git.rb"
apply "#{@partials}/_rvm.rb"          # Must be after gemfile since it runs bundler
apply "#{@partials}/_hobo.rb"         # Hoboize the new project
apply "#{@partials}/_cleanup.rb"
apply "#{@partials}/_application.rb"
apply "#{@partials}/_appconfig.rb"
apply "#{@partials}/_compass.rb"
apply "#{@partials}/_helpers.rb"
apply "#{@partials}/_stylesheets.rb"
apply "#{@partials}/_capistrano.rb"


puts "\n========================================================="
puts " INSTALLATION COMPLETE!".yellow.bold
puts "=========================================================\n\n\n"