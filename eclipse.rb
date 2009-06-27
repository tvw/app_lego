file '.project', <<-FE
<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
        <name>#{ask("Enter project name:")}</name>
        <comment></comment>
        <projects>
        </projects>
        <buildSpec>
                <buildCommand>
                        <name>org.rubypeople.rdt.core.rubybuilder</name>
                        <arguments>
                        </arguments>
                </buildCommand>
        </buildSpec>
        <natures>
                <nature>org.rubypeople.rdt.core.rubynature</nature>
                <nature>org.radrails.rails.core.railsnature</nature>
        </natures>
</projectDescription>
FE

file '.loadpath', <<-FE
<?xml version="1.0" encoding="UTF-8"?>
<loadpath>
        <pathentry excluding=".git/**" path="" type="src"/>
        <pathentry path="org.rubypeople.rdt.launching.RUBY_CONTAINER" type="con"/>
        <pathentry path="GEM_LIB/rails-2.3.2/lib" type="var"/>
        <pathentry path="GEM_LIB/actionpack-2.3.2/lib" type="var"/>
        <pathentry path="GEM_LIB/activerecord-2.3.2/lib" type="var"/>
        <pathentry path="GEM_LIB/activesupport-2.3.2/lib" type="var"/>
</loadpath>
FE

git :add => "."
git :commit => "-a -m 'Eclipse project added'"