gem 'thoughtbot-clearance', :lib => "clearance", :source => "http://gems.github.com"

rake "gems:install", :sudo => true

git :add => '.'
git :commit => "-a -m 'We have clearance, Clarence.'"