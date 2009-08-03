module AppLego
  module Base

    # TODO under development...
    def depends(*bricks)
      bricks.each do |brick|
        #TODO install brick
      end
    end


    ##
    ## additions to rails-2.x.y/lib/rails_generator/generators/applications/app/template_runner.rb
    ##

    # Has the specified gem alreaady been added?
    def gem_installed?(name, options = {})
      env = options.delete(:env)

      gems_code = "config.gem '#{name}'"

      if options.any?
        opts = options.inject([]) {|result, h| result << [":#{h[0]} => #{h[1].inspect.gsub('"',"'")}"] }.sort.join(", ")
        gems_code << ", #{opts}"
      end

      environment? gems_code, :env => env
    end

    # Search for data in environment file(s); returns true ony if found in all environments requested
    def environment?(data, options = {})
      if options[:env].nil?
        File.open("config/environment.rb") do |f|
          !f.grep(/#{Regexp.escape(data)}/).empty?
        end
      else
        data_found = true
        Array.wrap(options[:env]).each do|env|
          File.open("config/environments/#{env}.rb") do |f|
            data_found &= !f.grep(/#{Regexp.escape(data)}/).empty?
          end
        end
        data_found
      end
    end

    def gem_with_check(name, options = {})
      unless gem_installed?(name, options)
        gem_without_check(name, options)
      else
        log "gem", "gem #{name} already installed"
      end
    end

    # TODO remove from app_lego!
    def braid(repo, dir, type=nil)
      log "braid", "add #{repo} #{dir}"
      run "braid add #{"-t #{type} " if type}#{repo} #{dir}"
    end

    def use_braid?
      in_root do
        return File.exists?(".braids")
      end
    end

    # Install plugins with braid if installed
    def plugin_with_braid(name, options)
      if use_braid?
        if options[:git] || options[:svn]
          in_root do
            `braid add -p #{options[:svn] || options[:git]}`
          end
        else
          log "! no git or svn provided for #{name}. skipping..."
        end
      else
        plugin_without_braid(name, options)
      end
    end

    # Is the plugin already installed?
    def plugin_installed?(name)
      in_root do
        File.exists?("vendor/plugins/#{name}")
      end
    end

    def plugin_with_check(name, options)
      unless plugin_installed?(name)
        plugin_without_check(name, options)
      else
        log "plugin", "plugin #{name} already installed"
      end
    end

    # Add data to end of ApplicationController (convenience method for file_insert)
    def application_controller(data = nil, &block)
      file_insert('app/controllers/application_controller.rb', {:before => "\nend"}, data, &block)
    end

    # Insert data (or block) file before/after a specified text
    # Defaults to before a line beginning with 'end' (expecting this to be last line in class/module definition)  
    def file_insert(filename, where = {:before => "\nend"}, data = nil, &block)
      #file_append!(filename, data, &block) if File(filename).exists?
      if File.exists?(filename)
        sentinel = where[:before] || where[:after]
        gsub_file filename, /(#{Regexp.escape(sentinel)})/mi do |match|
          "\n" << "#{match if where[:after]}" << (block_given? ? block.call : data) << "\n" << "#{match if where[:before]}"
        end
      end
    end

#    # Append data to end of a file.  File will be created if it didn't exist.
#    def file_append!(filename, data = nil, &block)
#      File.open(filename, "a") do |f|
#        f << "\n" << (block_given? ? block.call : data) << "\n"
#      end
#    end

#    # Add data to application layout
#    # sections: head | body
#    # location: top | bottom
#    def layout(data, options = {})
#      section = options.delete(:section) || 'head'
#      location = options.delete(:location) || 'bottom'
#      #
#      # TODO
#      #
#    end

    # Is haml installed?
    def use_haml?
      File.exists?('vendor/plugins/haml')
    end

    # Are we using RSpec?
    def use_rspec?
      File.exists?('spec')
    end

    # Is sudo required for gem installation et.al.?
    def use_sudo?
      @use_sudo ||= ENV['USE_SUDO'] || ["y", "yes", ""].index(ask('use sudo? (defaults to yes)').downcase)
    end

  end
end

# Include into current template
extend AppLego::Base
alias :gem_without_check :gem
alias :gem :gem_with_check
alias :plugin_without_braid :plugin
alias :plugin :plugin_with_braid
alias :plugin_without_check :plugin
alias :plugin :plugin_with_check
