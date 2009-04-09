# freeze edge rails
if respond_to?(:braid)
  braid "git://github.com/rails/rails.git", "vendor/rails"
else
  # Guess full Rails path
  rails_path = Pathname.new($LOAD_PATH.find {|p| p =~ /railties/}.gsub(%r{/railties/.*}, '')).realpath
  run "cp -r '#{rails_path}' vendor/rails"
  run "rm -rf vendor/rails/.git"
end

# commit changes
git :add => "."
git :commit => "-a -m 'frozen edge rails'"

log "rails", "edge frozen"
