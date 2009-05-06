unless File.exists?('vendor/plugins/haml')
  log "info", "Compass requires Haml module; will install it now"
  templ = "#{@base_path}/haml.rb"
  log "applying", templ
  load_template(templ)
  log "applied", templ
end

gem 'chriseppstein-compass', :lib => 'compass', :version => '>= 0.3.4'

framework = (ENV['COMPASS_FRAMEWORK'] || ask('which framework you want to use? [blueprint | yui] (defaults to blueprint)'))
framework = "blueprint" if framework.nil? || framework.empty?

run "echo -e 'y\ny\n' | compass --rails -f #{framework} ."

git :add => "."
git :commit => "-a -m 'Added compass for css using #{framework} framework'"
