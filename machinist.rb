plugin 'machinist', :git => 'git://github.com/notahat/machinist.git'

git :rm => '-r spec/fixtures'
run "mkdir spec/blueprints"

file 'spec/blueprints_helper.rb', <<-BP
You can set Sham defaults here
Sham.name { faker or forgery }
  
Dir[File.expand_path(File.dirname(__FILE__)) + "/blueprints/**/*_blueprint.rb"].each do |blueprint|
  require blueprint
end
BP

file 'spec/spec_helper.rb', <<-SH
#This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
Dir[File.expand_path(File.dirname(__FILE__)) + "/blueprints/**/*_blueprint.rb"].each do |blueprint|
  require blueprint
end
require 'spec/autorun'
require 'spec/rails'
   
Spec::Runner.configure do |config|
  # Only for ActiveRecord
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures = false
           
  # reset our shams (machinist)
  config.before(:each) { Sham.reset }
end
SH

git :add => '.'

git :commit => "-a -m 'Added machinist. fixtures aren't fun.'"

