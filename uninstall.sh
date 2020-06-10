#!/bin/sh

echo "Removing symbolic links to vimrc files..."
rm -f $HOME/vimrc

echo "Removing all vim files..."
rm -rf ~/.vim
