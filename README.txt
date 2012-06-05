Windows Installation:

	git clone git://github.com/jdgiese/dotvim.git C:\opt\vim

Create symlinks:

	mklink C:\opt\vim\_vimrc C:\opt\vim\vimfiles\_vimrc 
	mklink C:\opt\vim\_gvimrc C:\opt\vim\vimfiles\_gvimrc 

Switch to the C:\opt\vim\vimfiles directory, and fetch the submodule:
	cd C:\opt\vim\vimfiles
	git submodule init
	git update

For some of the utilities to work, you will need to have the following programs on the $PATH:
    latex
    bibtex
    git
    ctags -- the ctags.exe is in the vimfiles/plugins directory
    fullscreen dll -- add to the directory where the gvim.exe is

