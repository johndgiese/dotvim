#!/bin/bash
# TODO: use a more generic shebang
set -e

echo "Setting up symbolic links..."
ln -svf $HOME/.vim/vimrc $HOME/.vimrc

if [ ! -d $HOME/.vim/autoload/plug.vim ]; then
    # TODO: check that curl exists
    echo "Installing vim-plug, a vim plugin manager,..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "Vim-plug already installed"
fi

echo "Installing plugins, may take a while ..."
vim +PlugInstall +qall

echo "Finished! Happy vimming!"
