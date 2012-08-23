require 'rubygems'
require 'irb/completion'
require 'what_methods'
require 'mathn'
require 'wirb'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:AUTO_INDENT] = true 

Wirb.start

#============================================================
#	Emurate Shell Commands
#============================================================
def cd(arg)
	DIR::chdir(arg)
end

def ls(*args)
	system "ls #{args.to_s}"
end

def la(*args)
	system "ls -a #{args.to_s}"
end

def ll(*args)
	system "ls -l #{args.to_s}"
end

def pwd
	Dir::pwd
end

def cal	
	system "cal"	
end

def q
	quit
end
