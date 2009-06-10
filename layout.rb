# Create an initial layout for application

# Detect whether stylesheets are placed in compiled directory
stylesheet_path_prefix = File.exists?('public/stylesheets/compiled') ? 'compiled/' : ''

if File.exists?('vendor/plugins/haml')

  file 'app/views/layouts/_flashes.html.haml', <<-HAML
#flash
  - flash.each do |key, value|
    %div{:id => "flash_\#{key}"}= value
  HAML

  file 'app/views/layouts/application.html.haml', <<-HAML
!!! XML
!!! Strict
%html{'xmlns' => 'http://www.w3.org/1999/xhtml', 'xml:lang' => 'en', 'lang' => 'en'}
  %head
    %meta{'http-equiv' => 'Content-Type', :content => 'text/html; charset=utf-8'}
    %title= "\#{page_title + ' - ' unless page_title.blank?}\#{t(:app_name)}"
    = stylesheet_link_tag '#{stylesheet_path_prefix}screen.css', :media => 'screen, projection'
    = stylesheet_link_tag '#{stylesheet_path_prefix}print.css', :media => 'print'
    /[if IE]
      = stylesheet_link_tag '#{stylesheet_path_prefix}ie.css', :media => 'screen, projection'
    = javascript_include_tag :defaults
  %body{:class => body_class}
    = render :partial => 'layouts/flashes'
    = yield
  HAML

else

  file 'app/views/layouts/_flashes.html.erb', <<-ERB
<div id="flash">
  <% flash.each do |key, value| -%>
    <div id="flash_<%= key %>"><%=h value %></div>
  <% end -%>
</div>
  ERB

  file 'app/views/layouts/application.html.erb', <<-ERB
<?xml version='1.0' encoding='utf-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title><%= page_title + ' - ' unless page_title.blank? %><%=t :app_name %></title>
    <%= stylesheet_link_tag '#{stylesheet_path_prefix}screen.css', :media => 'screen, projection' %>
    <%= stylesheet_link_tag '#{stylesheet_path_prefix}print.css', :media => 'print' %>
    <!--[if IE]>
    <%= stylesheet_link_tag '#{stylesheet_path_prefix}ie.css', :media => 'screen, projection' %>
    <![endif]-->
    <%= javascript_include_tag :defaults %>
  </head>
  <body class="<%= body_class %>">
    <%= render :partial => 'layouts/flashes' -%>
    <%= yield %>
  </body>
</html>
  ERB

end


