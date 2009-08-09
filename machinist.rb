gem 'notahat-machinist', :lib => 'machinist', :source => "http://gems.github.com", :env => :test

git :rm => '-r spec/fixtures'
run "mkdir spec/blueprints"

file 'spec/blueprints_helper.rb', <<-BP
require 'machinist/active_record'
require 'faker'
require 'sham'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraph }
  
Dir[File.expand_path(File.dirname(__FILE__)) + "/blueprints/**/*_blueprint.rb"].each do |blueprint|
  require blueprint
end
BP

gsub_file 'spec/spec_helper.rb', /(defined?(RAILS_ROOT).*)/, "\\1\nrequire File.dirname(__FILE__) + '/blueprints_helper'"

git :add => "."
git :commit => "-m 'Added machinist. fixtures aren`t fun.'"

