# Install sqlite3-ruby gem with correct lib (breaks otherwise on some systems)
gem "sqlite3-ruby", :lib => "sqlite3"

rake "gems:install", :sudo=>true

git :add => "."
git :commit => "-a -m 'Added sqlite3-ruby'"
