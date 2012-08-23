#!/usr/bin/ruby
$install_verbose = true
Modlist = [
	'what_methods',
	'wirb',
	'mechanize'
]

def verbose(type, mod)
	return	if $install_verbose != true

	msg = String.new
	msg << mod << "  "
	case type
	when :install
		msg << "Installed "
	when :available
		msg << "already available (pass)"
	end
	STDERR.write( (msg.chomp) + "\n" )
end

require 'rubygems'
def install_mod(modname)
	if Gem.available?(modname)
		verbose(:available, modname)
	else
		system "gem install #{modname}"
	end
end

#============================================================
#	Main Routine
#============================================================
if __FILE__ == $0
	Modlist.each {|mod|	install_mod(mod) }
end
