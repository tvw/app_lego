# remove tmp dirs
run "rm -Rf tmp/{pids,sessions,sockets,cache}"

# remove unnecessary stuff
run "rm README public/index.html public/images/rails.png"

# keep empty dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")

# init git repo
git :init

# basic .gitignore file
file '.gitignore',
%q{log/*.log
log/*.pid
db/*.db
db/*.sqlite3
db/schema.rb
tmp/**/*
*.*~
.DS_Store
doc/api
doc/app
config/database.yml
autotest_result.html
coverage
public/javascripts/*_[0-9]*.js
public/stylesheets/*_[0-9]*.css
public/attachments
}

unless yes?("Do you want to use timestapped migrations?")
  gsub_file 'config/environment.rb', /(Rails::Initializer.*)/, "\\1\n  config.active_record.timestamped_migrations = false"
end

# commit changes
git :add => "."
git :commit => "-a -m 'Setting up a new rails app'"

log "initialized", "application structure"
