gem 'haml', :version => '>= 2.0'
gem 'chriseppstein-compass', :lib => 'compass', :version => '>= 0.3.4'

rake "gems:install"

run "haml --rails ."
run "echo -e 'y\nn\n' | compass --rails -f blueprint"

git :add => "."
git :commit => "-a -m 'Added haml for views and compass for css'"
