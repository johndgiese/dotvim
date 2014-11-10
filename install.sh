#!/bin/bash
set -e

echo -e "\nSETTING UP SYMBOLIC LINKS..."
ln -svf $HOME/.vim/vimrc $HOME/.vimrc
ln -svf $HOME/.vim/gvimrc $HOME/.gvimrc

if [[ -f $HOME/.vim/bundle/Vundle.vim ]]; then
    echo -e "\nINSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
    git clone -v https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
else
    echo -e "\nVUNDLE ALREADY INSTALLED"
fi

echo -e "\nINSTALLING PLUGINS, MAY TAKE A WHILE ..."
vim +PluginInstall +qall

echo -e "\nCompiling YouCompleteMe"
$HOME/.vim/bundle/YouCompleteMe/install.sh

echo -e "\nFINISHED!  HAPPY VIMMING!"
