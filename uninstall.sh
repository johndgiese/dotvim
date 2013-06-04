#!/bin/bash

while true; do
    echo "The current user's home directory is:"
    echo ~

    read -p "Uninstall custom vim files for the current user? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Removing symbolic links to vimrc files..."
rm -f ~/vimrc
rm -f ~/gvimrc

echo "Removing all vim files..."
rm -rf ~/.vim
