#!/bin/bash

echo -e "\nLOOKING FOR VIM CUSTOMIZATION DIRECTORY..."
if [ -d ".vim" ]; then
    DOTVIM=".vim"
else
    echo "No vim customization directory found!"
    exit 1
fi
echo "Found vim customization directory: $HOME/$DOTVIM."

echo -e "\nSETTING UP SYMBOLIC LINKS..."
ln -sv $HOME/$DOTVIM/vimrc $HOME/.vimrc
ln -sv $HOME/$DOTVIM/gvimrc $HOME/.gvimrc

echo -e "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
git clone -v https://github.com/gmarik/vundle.git ~/$DOTVIM/bundle/vundle

echo -e "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
sleep 1
vim -c "execute 'BundleInstall' | quitall!"

echo -e "\nFINISHED!  HAPPY VIMMING!"
