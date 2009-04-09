gem 'chriseppstein-compass', :lib => 'compass', :version => '>= 0.3.4'

run "echo -e 'y\nn\n' | compass --rails -f blueprint"

git :add => "."
git :commit => "-a -m 'Added compass for css'"
