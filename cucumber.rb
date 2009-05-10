gem 'cucumber', :env => test
gem 'webrat', :env => test

rake "gems:install", :sudo => true

generate 'cucumber'

git :add => '.'
git :commit => "-a -m 'Added Cucumber for features.'"
