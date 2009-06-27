# see http://github.com/aslakhellesoy/cucumber
# see also http://github.com/bmabey/cucumber-tmbundle
gem 'cucumber', :env => :test
gem 'webrat', :env => :test

generate 'cucumber'

git :add => '.'
git :commit => "-a -m 'Added Cucumber for features.'"
