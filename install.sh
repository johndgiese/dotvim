#!/bin/bash

echo "SETTING UP SYMBOLIC LINKS..."
ln -sv ~/.vim/vimrc ~/.vimrc
ln -sv ~/.vim/gvimrc ~/.gvimrc

echo "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
git clone -v https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
sleep 1
vim -c "execute 'BundleInstall' | quitall!"

echo "\nFINISHED!  HAPPY VIMMING!"
