plugin "jrails", :git => "git://github.com/aaronchi/jrails"
plugin "jrails_in_place_editing", :git => "git://github.com/rakuto/jrails_in_place_editing"

rake 'jrails:install:javascripts'
#rake 'jrails:inplace:install:javascripts' # script missing from plugin so we need to copy manually...
js_dir = "javascripts"
js_file = "jquery.inplace.pack.js"
dest_file = File.join('public', js_dir, js_file)
src_file = File.join('vendor', 'plugins', 'jrails_in_place_editing', js_dir, js_file)
FileUtils.cp(src_file, dest_file)

git :add => "."
git :commit => "-m 'Installed JRails'"
