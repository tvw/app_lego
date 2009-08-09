plugin "recaptcha", :git => "git://github.com/ambethia/recaptcha.git"

file_append 'config/environments/production.rb', <<-TXT

  ENV['RECAPTCHA_PUBLIC_KEY'] = "Put your production public key here"
  ENV['RECAPTCHA_PRIVATE_KEY'] = "Put your production private key here"
TXT

dev_keys = <<-TXT

  ENV['RECAPTCHA_PUBLIC_KEY'] = "Put your development public key here"
  ENV['RECAPTCHA_PRIVATE_KEY'] = "Put your development private key here"
TXT

file_append 'config/environments/production.rb', dev_keys
file_append 'config/environments/test.rb', dev_keys
file_append 'config/environments/cucumber.rb', dev_keys if File.exists? 'config/envrionments/cucumber.rb' # Checking to supress warning if not exists

git :add => "."
git :commit => "-m 'Installed Recaptcha'"
