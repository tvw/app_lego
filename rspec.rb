gem 'rspec', :env => 'test'
gem 'rspec-rails', :env => 'test'
gem 'quietbacktrace', :env => %w[development test]

rake 'gems:install', :sudo=>true, :env => "test"

generate "rspec"

# remove test dir
git :rm => '-r test'

git :add => "."
git :commit => "-a -m 'Added RSpec for testing'"
