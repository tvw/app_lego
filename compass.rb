gem 'chriseppstein-compass', :lib => 'compass', :version => '>= 0.3.4'

framework = (ENV['COMPASS_FRAMEWORK'] || ask('which framework you want to use? [blueprint | yui] (defaults to blueprint)'))
framework = "blueprint" if framework.nil? || framework.empty?

run "echo -e 'y\ny\n' | compass --rails -f #{framework} ."

file "app/views/layouts/application.html.haml", <<-HAML
%head
  = stylesheet_link_tag 'compiled/screen.css', :media => 'screen, projection'
  = stylesheet_link_tag 'compiled/print.css', :media => 'print'
  /[if IE]
    = stylesheet_link_tag 'compiled/ie.css', :media => 'screen, projection'
HAML

git :add => "."
git :commit => "-a -m 'Added compass for css using #{framework} framework'"
