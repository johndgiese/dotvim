Windows Installation:

	git clone git://github.com/jdgiese/dotvim.git C:\opt\vim

Create symlinks:

	mklink /h C:\opt\vim\_vimrc C:\opt\vim\vimfiles\_vimrc 
	mklink /h C:\opt\vim\_gvimrc C:\opt\vim\vimfiles\_gvimrc 

Switch to the C:\opt\vim\vimfiles directory, and fetch the submodule:
	cd C:\opt\vim\vimfiles


For some of the utilities to work, you will need to have the following programs on the $PATH:
    latex
    bibtex
    git
    ctags -- the ctags.exe is in the vimfiles\extra
    fullscreen dll -- (in extra) add to the directory where the gvim.exe is

