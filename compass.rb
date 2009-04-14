gem 'chriseppstein-compass', :lib => 'compass', :version => '>= 0.3.4'

run "echo -e 'y\nn\n' | compass --rails -f blueprint"

framework = ask("wich framework you want to use? defaults to blueprint")

framework ||= "blueprint"

system "compass --rails -f #{framework} ."

file "app/views/layouts/application.html.haml", <<-HAML
%head
  = stylesheet_link_tag 'compiled/screen.css', :media => 'screen, projection'
  = stylesheet_link_tag 'compiled/print.css', :media => 'print'
  /[if IE]
    = stylesheet_link_tag 'compiled/ie.css', :media => 'screen, projection'
HAML

git :add => "."
git :commit => "-a -m 'Added compass for css'"
