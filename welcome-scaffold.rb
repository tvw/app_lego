# Generate a simple welcome page scaffold
if File.exists?('spec')
  generate :rspec_controller, "welcome index"
  File.delete("spec/helpers/welcome_helper_spec.rb")
else
  generate :controller, "welcome index"
  File.delete("test/unit/helpers/welcome_helper_test.rb")
end
route "map.root :controller => 'welcome'"

File.delete("app/helpers/welcome_helper.rb")

git :add => "."
git :commit => "-m 'Added Welcome scaffold as homepage'"
