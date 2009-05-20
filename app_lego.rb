# environment options
@lego_options = ENV['LEGOS'] ? ENV['LEGOS'].downcase.split(/[,\s]+/) : false
@used_legos = []

# Check for module dependencies
def deps_satisfied?(deps)
  deps.each do |dep|
    if dep.to_s =~ /^no_(.*)$/
      return false if @used_legos.include?( $1 )
    else
      return false unless @used_legos.include?( dep.to_s )
    end
  end
  
  true
end

def use_lego?(lego, question, *deps)
  use = if @lego_options
    @lego_options.include?(lego)
  elsif deps_satisfied?(deps)
    yes?(question)
  else
    false
  end
  
  @used_legos << lego if use
  
  use
end

# braid helpers
if use_lego?("braid", "Use braid for vendor management?")
  run "sudo gem install braid" unless run("gem list -i braid", :show_response=>true)

  def braid(repo, dir, type=nil)
    run "braid add #{"-t #{type} " if type}#{repo} #{dir}"
  end

  def plugin(name, options)
    log "braid plugin", name

    if options[:git] || options[:svn]
      in_root do
        `braid add -p #{options[:svn] || options[:git]}`
      end
    else
      log "! no git or svn provided for #{name}. skipping..."
    end
  end
end

modules = [

  # Basic legos

  ["basic",   "Do basic setup? (only exclude this if you already have a Rails app skeleton with Rails 2.3+ frozen, or as a gem)"],
  ["frozen_edge", "Freeze edge Rails?"],
  ["sqlite3", "Use sqlite3?"],

  # Stylesheets

  ["haml",    "Use haml for views and sass for css?"], # must be before generating any templates
  ["compass", "Use compass for CSS?", :haml ], # install only if haml installed
  
  # Testing

  ["rspec",   "Use RSpec instead of Test::Unit?"], # must be before any generators etc. who may test for RSpec
  ["shoulda", "Add Shoulda testing capabilities?", :no_rspec ], # don't install with rspec

  ["cucumber","Install Cucumber/Webrat integration testing framework?"],
  ["webrat",  "Install Webrat web browser simulator for integration testing?", :cucumber ], # only if cucumber installed

  ["mocha", "Add Mocha mocking and stubbing library?"],

  ["factory_girl","Add factory_girl fixture generation?" ],
  ["machinist","Add machinist fixture generation?", :no_factory_girl ],
  ["object_daddy","Add object_daddy fixture generation?", :no_factory_girl, :no_machinist ],

  # Modules

  ["hoptoad", "Use Hoptoad error notifier?"],  
  
  # Javascripts
  
  ["jquery",  "Use jQuery instead of Prototype + Script.aculo.us?"],
  ["jrails", "install jquery for rails plugin?", :jquery ], # requires jquery
  
  # Authentication

  ["auth", "Add AuthLogic authentication engine?"],
  ["authlogic-scaffold", "Add scaffold for Authlogic?", :auth ], # requires authentication
  ["clearance", "Add Clearance authentication engine?", :no_auth ],

  ["aasm", "install aasm state machine?"],
  ["acts-as-taggeable-on", "install acts-as-taggeable-on?"],

  ["locale", "Add specific localizations?"],
  ["layout", "Add basic layout?"],
  ["misc", "Add miscellaneous stuff (helpers, basic layout, flashes, initializers)?"],
  ["welcome-scaffold", "Add a welcome page scaffold?"],
  
  # Admin

  ["typus", "Add Typus admin panel?"],
]

if @lego_options or yes?("Do you want to play LEGO?")
  
  @base_path = if template =~ %r{^(/|\w+://)}
    File.dirname(template)
  else
    log '', "You used the app generator with a relative template path."
    ask "Please enter the full path or URL where the modules are located:"
  end

  modules.each do |modul|
    if use_lego?(*modul)
      tmpl = "#{@base_path}/#{modul[0]}.rb"
      log "applying", "template: #{tmpl}"
      load_template(tmpl)
      log "applied", tmpl
    end
  end
  
  rake "gems:install", :sudo => true
  rake "db:migrate"
end
