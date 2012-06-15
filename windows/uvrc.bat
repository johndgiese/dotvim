cd C:\opt\vim\.vim

:: make symbolic links for .vim and the .vim/vimrc
if not exist C:\opt\vim\vimfiles mklink /D C:\opt\vim\vimfiles C:\opt\vim\.vim
if not exist C:\opt\vim\_vimrc mklink C:\opt\vim\_vimrc C:\opt\vim\vimfiles\vimrc
if not exist C:\opt\vim\_gvimrc mklink C:\opt\vim\_gvimrc C:\opt\vim\vimfiles\gvimrc

:: add temporary directories for undo, swap, and backup files
if not exist C:\opt\vim\tmp\undo mkdir C:\opt\vim\tmp\undo
if not exist C:\opt\vim\tmp\backup mkdir C:\opt\vim\tmp\backup
if not exist C:\opt\vim\tmp\swap mkdir C:\opt\vim\tmp\swap

:: pull changes from git
git pull

:: setup submodules
git submodule init
git submodule update
