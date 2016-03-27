#!/bin/bash
set -e

echo -e "\nSETTING UP SYMBOLIC LINKS..."
ln -svf $HOME/.vim/vimrc $HOME/.vimrc
ln -svf $HOME/.vim/gvimrc $HOME/.gvimrc

if [ ! -d $HOME/.vim/bundle ]; then
    mkdir $HOME/.vim/bundle
fi

if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
    echo -e "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
    git clone -v https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
else
    echo -e "\nVUNDLE ALREADY INSTALLED"
fi

echo -e "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
vim +PluginInstall +qall

# see https://bugs.launchpad.net/ultisnips/+bug/1067416
echo -e "\nSetting up symbolic links for ultisnips"
mkdir -p ~/.vim/after/plugin
ln -fs ~/.vim/bundle/ultisnips/after/plugin/* ~/.vim/after/plugin
mkdir -p ~/.vim/ftdetect
ln -fs ~/.vim/bundle/ultisnips/ftdetect/* ~/.vim/ftdetect

echo -e "\nCompiling YouCompleteMe"
$HOME/.vim/bundle/YouCompleteMe/install.sh

echo -e "\nFINISHED!  HAPPY VIMMING!"
