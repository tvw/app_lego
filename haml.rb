gem 'haml', :version => '>= 2.1'

run "haml --rails ."

git :add => "."
git :commit => "-a -m 'Added haml for views'"
