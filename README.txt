# Installation on Windows
    This assumes that your vim directory is in: C:\opt\vim, modify as necessary.

	git clone git://github.com/johndgiese/dotvim.git C:\opt\vim\.vim

For some of the utilities (e.g. the ctags programs) to work, you will need to add the vimfiles\onpath 
directory to the windows PATH:

    setx PATH "%PATH%;C:\opt\vim\.vim\onpath" -M

(Note: if you only want to add it to the current user's path, omit the -M)
        
Run the uvrc.bat file.  This does a few things:
# Creates a symbolic link: vimfiles <==> .vim
# Creates a symbolic link: .vim/vimrc <==> _vimrc
# Initializes and updates the git submodules with the vim plugins

# How this vim setup differs from normal vim

* <ESC> in insert mode is now jk (quickly, one after another).  This mapping allows you to keep your hands still.
* Swaps the semicolon and colon, because you use colon a lot and almost never use semicolon
* F1 opens nerdtree
* F2 opens the ctag viewer
* F3 is the mini-buffer explorer
* F4 opens the gundo plugin
* The new <leader> key is , instead of /
* Searches (pressing / or ? in normal mode) now have \v prepended so that vim uses the verymagic mode (i.e. it uses normal python/perl regular expressions instead of its own version)
* <leader>/ clears search highlighting
* <leader>s (i.e. ,s) starts spell search
* <leader>v opens the vimrc (which auto runs upon saving)
* <leader>o opens the colorscheme file for easy updating
* <leader>h will highlight the colors of all hex keys

The following other plugins are installed:
* Fugitive
* Surround 
* Vipy
* Autoclose
* Snipmate
* Session
* Unimpaired
* ... a few other little ones
