gem 'cucumber'
gem 'webrat'

generate 'cucumber'

git :add => '.'
git :commit => "-a -m 'Added Cucumber for features.'"
