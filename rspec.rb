gem 'rspec', :lib => false, :env => :test
gem 'rspec-rails', :lib => false, :env => :test

generate "rspec"

# remove test dir
git :rm => '-r test'

# change default rspec format option from progress to specdoc
file "spec/spec.opts", <<-OPTS
--colour
--format specdoc
--loadby mtime
--reverse
OPTS

git :add => "."
git :commit => "-m 'Added RSpec for testing'"
