#!/bin/bash

echo -e "\nLOOKING FOR VIM CUSTOMIZATION DIRECTORY..."
if [ -d ".vim" ] && [ -d "vimfiles" ]; then
    echo "Both a '.vim' and 'vimfiles' folder is present."
    echo "Please remove one before proceeding."
    exit 1
fi

if [ -d ".vim" ]; then
    DOTVIM=".vim"
    IS_WINDOWS="FALSE"
elif [ -d "vimfiles" ]; then
    DOTVIM="vimfiles"
    IS_WINDOWS="TRUE"
else
    echo "No vim customization directory found!"
    exit 1
fi
echo "Found vim customization directory: $HOME/$DOTVIM."

echo -e "\nSETTING UP SYMBOLIC LINKS..."
if [ "$IS_WINDOWS" == "TRUE" ]; then
    ln -sv ~/$DOTVIM/vimrc ~/_vimrc
    ln -sv ~/$DOTVIM/gvimrc ~/_gvimrc
else
    ln -sv ~/$DOTVIM/vimrc ~/.vimrc
    ln -sv ~/$DOTVIM/gvimrc ~/.gvimrc
fi

echo -e "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
git clone -v https://github.com/gmarik/vundle.git ~/$DOTVIM/bundle/vundle

echo -e "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
sleep 1
vim -c "execute 'BundleInstall' | quitall!"

echo -e "\nFINISHED!  HAPPY VIMMING!"
