# Install Mocha mocking and stubbing library
# see http://github.com/floehopper/mocha
gem "mocha", :env => :test

rake "gems:install", :sudo => use_sudo?, :env => :test

git :add => '.'
git :commit => "-a -m 'Added Mocha mocking and stubbing library.'"
