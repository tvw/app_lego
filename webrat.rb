gem 'webrat', :env => :test
rake "gems:install", :sudo => true, :env => :test

git :add => '.'
git :commit => "-a -m 'Added Webrat web browser simulator for integration testing.'"
