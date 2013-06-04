#!/bin/bash

while true; do
    if [ ! -d "$HOME" ]; then
        echo "No \$HOME directory found."
        exit 1
    fi

    if [ -d ~/.vim ]; then
        IS_WINDOWS= "FALSE"
        echo "Found vim customization directory : $HOME/.vim."
    elif [ -d ~/vimfiles ]; then
        IS_WINDOWS= "TRUE"
        echo "Found vim customization directory : $HOME/vimfiles."
    else
        echo "No vim customization directory found!"
        exit 1
    fi

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
if [ $IS_WINDOWS == "TRUE" ]; then
    rm -rf ~/vimfiles
else
    rm -rf ~/vimfiles
fi
