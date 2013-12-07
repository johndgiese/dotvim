#!/bin/sh

function errcheck {
    if [ $? -ne 0 ]; then 
        echo -e "\nERROR, quitting"
        exit 1 
    fi
}


echo -e "\nCompiling YouCompleteMe"
cd $HOME/.vim/bundle/YouCompleteMe
sh install.sh
errcheck

echo -e "\nUPDATING PLUGINS, MAY TAKE A WHILE ..."
vim -c "execute 'BundleInstall!' | quitall!"
errcheck
