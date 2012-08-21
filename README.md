# Installation on Windows
This assumes that your vim directory is in: C:\opt\vim, modify as necessary.

	git clone git://github.com/johndgiese/dotvim.git C:\opt\vim\.vim

For some of the utilities (e.g. the ctags programs) to work, you will need to add the vimfiles\onpath 
directory to the windows PATH:

	setx PATH "%PATH%;C:\opt\vim\.vim\windows" -M

(Note: if you only want to add it to the current user's path, omit the -M)
        
Run the uvrc.bat file (you can just navigate to the directory and double click it), it will prompt you for your install directory (make sure you include double quotes if you installed in Program Files or Program Files (x86)).  This does a few things:
1. Creates a symbolic link: vimfiles <==> .vim
2. Creates a symbolic link: .vim/vimrc <==> _vimrc
3. Initializes and updates the git submodules with the vim plugins

You need to update a single directory in your vimrc (the line is towards the top of the file)

Finally, if you want to use the vipy plugin you will need to run another batch script, as described in the install instructions [here](https://github.com/johndgiese/vipy)

# How this vim setup differs from normal vim

* Much better colorscheme.
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
* Autocomplete uses <tab> unless there is white space before the cursor
* Tabs are replaced with four spaces

The following other plugins are installed:
* Fugitive
* Surround 
* Vipy
* Autoclose
* Snipmate
* Session
* Unimpaired
* Supertab
* ... a few other little ones
