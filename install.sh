#!/bin/bash
set -e

PLUG_VIM="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim
PLUG_VIM_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if [ -f $PLUG_VIM ]; then
    echo "Vim-plug already installed"
else
    echo "Installing vim-plug, a vim plugin manager, ..."
    curl -fLo "$PLUG_VIM" --create-dirs "$PLUG_VIM_URL"
fi

echo "Installing plugins, may take a while ..."
vim +PlugInstall +qall

echo "Finished! Happy vimming!"
