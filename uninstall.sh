#!/bin/sh

echo -e "\nRemoving symbolic links to vimrc files..."
rm -f $HOME/vimrc
rm -f $HOME/gvimrc

echo -e "\nRemoving all vim files..."
rm -rf ~/.vim
