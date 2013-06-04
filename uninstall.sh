#!/bin/bash

while true; do
    echo "The current user's vim customization directory is:"
    if [ -d "~/.vim" ]; then
        $DOTVIM = ~/.vim
        $OS = "NOT WINDOWS"
    elif [ -d "~/vimfiles" ]; then
        $DOTVIM = ~/vimfiles
        $OS = "WINDOWS"
    else
        echo "\nNo vim customization directory found!"
        exit 1
    fi
    echo "\nFound vim customization directory : $DOTVIM."

    read -p "Uninstall all custom vim files for the current user [yes or no]? " yn
    case $yn in
        yes ) break;;
        no ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Removing symbolic links to vimrc files..."
if [ $OS == "WINDOWS" ]; then
    rm -f ~/.vimrc
    rm -f ~/.gvimrc
else
    rm -f ~/_vimrc
    rm -f ~/_gvimrc
fi

echo "Removing all vim files..."
if [ $OS == "WINDOWS" ]; then
    rm -rf ~/_vim
else
    rm -rf ~/_vim
fi
