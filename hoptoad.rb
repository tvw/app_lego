plugin 'hoptoad_notifier', :git => "git://github.com/thoughtbot/hoptoad_notifier"

hoptoad_key = ask("\nPlease enter your Hoptoad API key: ")
initializer "hoptoad.rb", <<-HOPTOAD
HoptoadNotifier.configure do |config|
  config.api_key = '#{hoptoad_key}'
end
HOPTOAD
