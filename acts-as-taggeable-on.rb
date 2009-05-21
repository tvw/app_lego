# Install acts-as-taggeable-on
# see http://github.com/mbleigh/acts-as-taggable-on
gem "mbleigh-acts-as-taggable-on", :lib => "acts-as-taggable-on"

rake "gems:install", :sudo => use_sudo?

generate "acts_as_taggable_on_migration"
rake "db:migrate"

git :add => "."
git :commit => "-a -m 'Added acts-as-taggable-on'"
