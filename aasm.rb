# Install aasm state machine
# see http://github.com/rubyist/aasm
gem "rubyist-aasm", :lib => "aasm"

rake "gems:install", :sudo=>true

git :add => "."
git :commit => "-a -m 'Added aasm state machine'"
