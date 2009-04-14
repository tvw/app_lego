gem 'rspec', :env => 'test'
gem 'rspec-rails', :env => 'test'

rake 'gems:install', :sudo=>true, :env => "test"

generate "rspec"

# remove test dir
git :rm => '-r test'

file "spec/spec.opts", <<-OPTS
--colour
--format specdoc
--loadby mtime
--reverse
OPTS

git :add => "."
git :commit => "-a -m 'Added RSpec for testing'"
