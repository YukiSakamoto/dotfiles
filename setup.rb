#!/usr/bin/ruby
#
Conf_Files = [
	'.vimrc',
	'.gvimrc',
	'.zshrc',
	'.zshrc.mine',
	'.irbrc',
	'.screenrc',
	'.pentadactylrc',
	'.tmux.conf',
]

Conf_Files.each do |f_name|
	`ln -s ~/dotfiles/#{f_name} ~/#{f_name}`
end

