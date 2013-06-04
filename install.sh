#!/bin/bash

echo "LOOKING FOR VIM CUSTOMIZATION DIRECTORY..."
if [ -d ".vim" ]; then
    $DOTVIM = ".vim"
    $OS = "NOT WINDOWS"
elif [ -d "vimfiles" ]; then
    $DOTVIM = "vimfiles"
    $OS = "WINDOWS"
else
    echo "\nNo vim customization directory found!"
    exit 1
fi
echo "\nFound vim customization directory: $DOTVIM."

echo "SETTING UP SYMBOLIC LINKS..."
if [ $OS == "WINDOWS"]; then
    ln -sv ~/$DOTVIM/vimrc ~/_vimrc
    ln -sv ~/$DOTVIM/gvimrc ~/_gvimrc
else
    ln -sv ~/$DOTVIM/vimrc ~/.vimrc
    ln -sv ~/$DOTVIM/gvimrc ~/.gvimrc
fi

echo "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
git clone -v https://github.com/gmarik/vundle.git ~/$DOTVIM/bundle/vundle

echo "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
sleep 1
vim -c "execute 'BundleInstall' | quitall!"

echo "\nFINISHED!  HAPPY VIMMING!"
