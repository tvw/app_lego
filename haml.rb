gem 'echoe'
gem 'haml', :version => '>=2.1'
gem 'chriseppstein-compass', :lib => 'compass', :source => 'http://gems.github.com'

unless system("gem list -i haml -v '>=2.1.0'")
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
framework = ask("wich framework you want to use? defaults to blueprint") || "blueprint"

system "compass --rails -f #{framework} ."

git :add => "."
git :commit => "-a -m 'Added haml for views and compass for css'"
