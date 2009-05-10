gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"

rake "gems:install", :sudo => true

git :add => '.'
git :commit => "-a -m 'Waiting for a girl who\'s got curlers in her hair; Waiting for a girl, she has no money anywhere; We get buses everywhere; Waiting for a factory girl...'"