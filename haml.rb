#gem 'echoe'
gem 'haml', :version => '>=2.1'

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

git :add => "."
git :commit => "-a -m 'Added haml for views'"
