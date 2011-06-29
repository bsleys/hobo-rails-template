# Set up default haml layout

puts "Running Hobo Wizard ...".magenta

run "cd .."
run "#{@rvm} exec hobo g setup_wizard"

#setup hobo-jquery
run "#{@rvm} exec rails plugin install git://github.com/bryanlarsen/hobo-jquery.git -r rails3"
run "#{@rvm} exec rails generate hobo_jquery:install"

inject_into_file 'app/views/taglibs/application.dryml', :after => '<include src="taglibs/auto/rapid/forms"/>' do
<<-RUBY

<include plugin="hobo-jquery" />
RUBY
end

append_to_file 'app/views/taglibs/application.dryml' do
<<-RUBY

<extend tag="page">
  <old-page merge>
    <custom-scripts:>
      <hjq-assets/>
    </custom-scripts>
  </old-page>
</extend>
RUBY
end

#setup paperclip_with_hobo
run "#{@rvm} exec rails plugin install git://github.com/tablatom/paperclip_with_hobo.git"
inject_into_file 'app/views/taglibs/application.dryml', :after => '<include src="taglibs/auto/rapid/forms"/>' do
<<-RUBY

<include src="paperclip" plugin="paperclip_with_hobo"/>
RUBY
end


puts "\n"

