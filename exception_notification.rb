plugin "exception_notification", :git => "git://github.com/rails/exception_notification.git"

file 'config/initializers/exception_notification.rb', <<-TXT
ExceptionNotifier.exception_recipients = %w(your.email@example.com)
ExceptionNotifier.sender_address = %("YourApplication Error" <admin@example.com>)
ExceptionNotifier.email_prefix = "[YourApplication Error]"
TXT

git :add => "."
git :commit => "-m 'Installed Exception Notification'"
