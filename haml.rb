gem 'haml', :version => '>=2.1'
gem 'chriseppstein-compass', :lib => 'compass', :source => 'http://gems.github.com'

unless run("gem list -i haml -v '>=2.1.0'", :show_response=>true)
  inside('tmp') do
    run "git clone git://github.com/nex3/haml.git" 
    inside('tmp/haml') do 
      run "sudo rake install"
    end
    run "sudo rm -rf haml"
  end
end
 
rake "gems:install", :sudo => true

run "haml --rails ."
if yes?("Do you wanna manually config compass?\n(defauls -> framework: blueprint\nsass stylesheets: app/stylesheets\ncompiled stylesheets: public/stylesheets")
  run "compass --rails -f #{ask("wich framework want to use")} .", :show_response=>true
else
  run "compass --rails -f blueprint .", :puts=>["y","n"]
end

git :add => "."
git :commit => "-a -m 'Added haml for views and compass for css'"
