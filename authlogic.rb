gem 'authlogic'

rake "gems:install", :sudo => use_sudo?

def user_model
  @user_model ||= ENV['USER_MODEL'] || ask("What should be the name of the user model?")
  @user_model = @user_model.underscore
end

def user_ident
  @user_ident ||= ENV['USER_IDENT'] || ask("What is the identifier of a user? (e.g. login, email)")
end

generate 'session', "#{user_model}_session"

# require in [test|spec]_helper.rb
test_or_spec = (File.exists?('spec') ? "spec" : "test")

File.open(File.join(test_or_spec,"#{test_or_spec}_helper.rb"), "a") do |file|
  file << "\nrequire 'authlogic/test_case'\n"
end

unless user_model.blank?
  migration = "#{user_ident}:string crypted_password:string password_salt:string persistence_token:string single_access_token:string perishable_token:string login_count:integer failed_login_count:integer last_request_at:datetime"

#for acts_as_authenticated "login_count:integer failed_login_count:integer last_request_at:datetime current_login_at:datetime last_login_at:datetime current_login_ip:string last_login_ip:string"

  if File.exists?('rspec')
    generate 'rspec_model', user_model, migration
  else
    generate 'model', user_model, migration
  end

  file "app/models/#{user_model.underscore}.rb", <<-RB
class #{user_model.classify} < ActiveRecord::Base
  acts_as_authentic # for options see documentation: Authlogic::ORMAdapters::ActiveRecordAdapter::ActsAsAuthentic::Config
end
  RB

  rake "db:migrate"
end

git :add => "."
git :commit => "-a -m 'Added AuthLogic#{" and #{user_model} model" unless user_model.blank?}'"
