#!/bin/bash
set -e

echo -e "\nSETTING UP SYMBOLIC LINKS..."
ln -sv $HOME/.vim/vimrc $HOME/.vimrc
ln -sv $HOME/.vim/gvimrc $HOME/.gvimrc

echo -e "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
git clone -v https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim

echo -e "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
vim +PluginInstall +qall

echo -e "\nCompiling YouCompleteMe"
cd $HOME/.vim/bundle/YouCompleteMe
sh install.sh

echo -e "\nFINISHED!  HAPPY VIMMING!"
