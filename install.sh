#!/bin/sh

echo -e "\nSETTING UP SYMBOLIC LINKS..."
ln -sv $HOME/.vim/vimrc $HOME/.vimrc
ln -sv $HOME/.vim/gvimrc $HOME/.gvimrc

echo -e "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
git clone -v https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo -e "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
vim -c "execute 'BundleInstall' | quitall!"

echo -e "\nCompiling YouCompleteMe"
cd $HOME/.vim/bundle/YouCompleteMe
sh install.sh
errcheck

echo -e "\nInstalling Tern's NPM dependencies"
cd $HOME/.vim/bundle/tern_for_vim
npm install
errcheck

echo -e "\nFINISHED!  HAPPY VIMMING!"
