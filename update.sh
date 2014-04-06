#!/bin/bash

function errcheck {
    if [ $? -ne 0 ]; then 
        echo -e "\nERROR, quitting"
        exit 1 
    fi
}

echo -e "\nUPDATING PLUGINS, MAY TAKE A WHILE ..."
vim -c "execute 'BundleInstall!' | quitall!"
errcheck

echo -e "\nCompiling YouCompleteMe"
cd $HOME/.vim/bundle/YouCompleteMe
./install.sh
errcheck

echo -e "\nInstalling Tern's NPM dependencies"
cd $HOME/.vim/bundle/tern_for_vim
npm install
errcheck

