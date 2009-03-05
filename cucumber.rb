gem 'cucumber'
gem 'webrat'

rake "gems:install"

generate 'cucumber'

git :add => '.'
git :commit => "-a -m 'Added Cucumber for features.'"
