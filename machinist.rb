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

gsub_file 'spec/spec_helper.rb', /(require 'spec\/rails'.*)/, "\\1\nrequire 'spec/blueprints_helper.rb'"

git :add => "."
git :commit => "-m 'Added machinist. fixtures aren`t fun.'"

