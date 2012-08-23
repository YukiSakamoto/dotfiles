require 'fileutils'

Except_Files = [ 
	".DS_Store", 
]

Home_Dir = ENV["HOME"]

Dest_Dir = Home_Dir + "dotfiles"

dotfilenames = Dir.glob("#{Home_Dir}/.*")
dotfilenames.each do |f_name|
	if Except_Files.include?(f_name) != true && File.directory?(f_name) != true
		#FileUtils.cp(f_name, Dest_Dir)
		printf "%s %s\n", File.directory?(f_name) ? "D" : " ", f_name 
	end
end

