# app files
file 'app/controllers/application_controller.rb', <<-APP
class ApplicationController < ActionController::Base

  helper :all

  protect_from_forgery

  filter_parameter_logging "password" unless Rails.env.development?

  #{"include HoptoadNotifier::Catcher" if File.exists?('vendor/plugins/hoptoad_notifier')}
end
APP

file 'app/helpers/application_helper.rb', 
%q{module ApplicationHelper
  def page_title(title=nil)
    if title.nil?
      @page_title ||= ""
    else
      @page_title = title
    end
  end

  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
end
}

# initializers

initializer 'requires.rb', 
%q{Dir[Rails.root.join('lib', '*.rb')].each do |f|
  require f
end
}

git :add => "."
git :commit => "-a -m 'Added basic ApplicationController, helpers, initializers'"
