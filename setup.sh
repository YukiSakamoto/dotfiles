#!/bin/sh

Conf_Files=(.vimrc .gvimrc .zshrc .zshrc.mine .irbrc .screenrc .pentadactylrc)

for f_name in ${Conf_Files[@]} 
do
	#echo "$f_name"
	ln -s ~/dotfiles/$f_name ~/$f_name
done

