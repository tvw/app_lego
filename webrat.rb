gem 'webrat', :env => :test
rake "gems:install", :sudo => use_sudo?, :env => :test

git :add => '.'
git :commit => "-a -m 'Added Webrat web browser simulator for integration testing.'"
