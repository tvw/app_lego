load_template File.join(File.dirname(template), "base.rb")

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
  gem "braid"
  rake "gems:install", :sudo => use_sudo?
  FileUtils.touch(".braids")
end

modules = [

  # Basic legos

  ["basic",   "Do basic setup? (only exclude this if you already have a Rails app skeleton with Rails 2.3+ frozen, or as a gem)"],
  ["frozen_edge", "Freeze edge Rails?"],
  ["sqlite3", "Use sqlite3?"],
  
  # IDE Integration
  
  ["eclipse", "Do you want to create Eclipse RDT project?" ],

  # Stylesheets

  ["haml",    "Use Haml for views and Sass for CSS?"], # must be before generating any templates
  ["compass", "Use compass for CSS?", :haml ], # install only if haml installed

  # Testing

  ["rspec",      "Use RSpec instead of Test::Unit?"], # must be before any generators etc. who may test for RSpec
  ["remarkable", "Add Remarkable testing capabilities?", :rspec ], # needs rspec
  ["shoulda",    "Add Shoulda testing capabilities?", :no_rspec ], # don't install with rspec

  ["cucumber","Install Cucumber/Webrat integration testing framework?"],
  ["webrat",  "Install Webrat web browser simulator for integration testing?", :no_cucumber ], # only if cucumber installed

  ["mocha",   "Add Mocha mocking and stubbing library?"],

  ["factory_girl", "Add factory_girl fixture generation?" ],
  ["machinist",    "Add machinist fixture generation?", :no_factory_girl ],
  ["object_daddy", "Add object_daddy fixture generation?", :no_factory_girl, :no_machinist ],

  # Modules
  
  ["hoptoad", "Use Hoptoad error notifier?"],
  ["exception_notification", "Use Exception Notification plugin?", :no_hoptoad],

  # Javascripts

  ["jrails",  "Use jQuery with jRails plugin?" ],
  ["jquery",  "Use jQuery without jRails plugin?", :no_jrails ], # install jquery without jrails

  # Authentication

  ["authlogic", "Add AuthLogic authentication engine?"],
  ["authlogic-scaffold", "Add scaffold for Authlogic?", :authlogic ], # requires authentication

  ["clearance", "Add Clearance authentication engine?", :no_authlogic ],

  # Others
  
  ["recaptcha", "Use Recaptcha?"],

  ["aasm", "Install aasm state machine?"],
  ["acts-as-taggeable-on", "Install acts-as-taggeable-on?"],

  ["browsercms",  "Add Browser CMS Gem?"],

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

  rake "gems:install", :sudo => use_sudo?
  rake "db:migrate"
end
