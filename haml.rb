gem 'haml', :version => '>= 2.1'
gem 'chriseppstein-compass', :lib => 'compass', :version => '>= 0.3.4'

run "git clone git://github.com/nex3/haml.git tmp/haml; cd tmp/haml; sudo rake install"
run "rm -rf haml"

rake "gems:install"

run "haml --rails ."
run "echo -e 'y\nn\n' | compass --rails -f blueprint"

git :add => "."
git :commit => "-a -m 'Added haml for views and compass for css'"
