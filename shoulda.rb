gem 'thoughtbot-shoulda', :lib => "shoulda", :source => "http://gems.github.com", :env => test

rake "gems:install", :sudo => true, :env => test

git :add => '.'
git :commit => "-a -m 'Added Shoulda, you shoulda know for features.'"