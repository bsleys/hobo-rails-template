# Set up rvm private gemset
if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
  begin
    rvm_path     = File.dirname(File.dirname(ENV['MY_RUBY_HOME']))
    rvm_lib_path = File.join(rvm_path, 'lib')
    $LOAD_PATH.unshift rvm_lib_path
    require 'rvm'
  rescue LoadError
    # RVM is unavailable at this point.
    raise "RVM ruby lib is currently unavailable."
  end
end

puts "Setting up RVM gemset  ... ".magenta

rvm_list = RVM.list_strings

current_ruby, current_gemset = RVM.environment_name.split('@')
puts "\nInstalled rubies".magenta
puts rvm_list

desired_ruby = ask("Which RVM Ruby would you like to use? [#{current_ruby}]".red)
desired_ruby = current_ruby if desired_ruby.blank?

gemset_name = ask("What name should the custom gemset have? [#{@app_name}]".red)
gemset_name = @app_name if gemset_name.blank?

# Create the gemset
run "rvm #{desired_ruby} gemset create #{gemset_name}"

# Let us run shell commands inside our new gemset. Use this in other template partials.
@rvm = "rvm use #{desired_ruby}@#{gemset_name}"

# Create .rvmrc
file '.rvmrc', @rvm
puts "                  #{@rvm}".yellow

# Make the .rvmrc trusted
run "rvm rvmrc trust #{@app_path}"

# Since the gemset is likely empty, manually install bundler so it can install the rest
run "#{@rvm} gem install bundler"
# we also need Hobo to hoboize the project
#run "#{@rvm} gem install hobo -v 1.3.0.RC --pre"

# Install all other gems needed from Gemfile
run "#{@rvm} exec bundle install"

puts "RVM setup completed\n".magenta

