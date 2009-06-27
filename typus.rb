# Install Typus and friends.

plugin 'typus', :git => 'git://github.com/fesplugas/typus.git'

if yes?("Install extra plugins? (for the demo is not needed)")
  plugin 'acts_as_list', :git => 'git://github.com/rails/acts_as_list.git'
  plugin 'acts_as_tree', :git => 'git://github.com/rails/acts_as_tree.git'
  plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
end

# Run generators.

if yes?("Create example Post and Page models?")
  generate("scaffold", "Post title:string body:text published:boolean", "--skip-timestamps")
  generate("scaffold", "Page title:string body:text published:boolean", "--skip-timestamps")
  
  rake "db:migrate"
  
  route "map.root :controller => 'posts'"
end

# Typus generator

generate "typus"

rake "db:migrate"