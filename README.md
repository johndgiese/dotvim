# Thoughts
I love vim because it is FAST, lightweight, powerful, works in the commandline, and is mostly OS independent. That being said, some of the default settings are no good, and there is a lot of missing functionality.  I have developed a set of customizations to vim that fix these problems.  In order to sync these changes across computers using various operating systems some additional complexity must be added in the installation process (see [here](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)).

Everyone has their own tastes, and will probably want to customize their setup further, so my vimrc is just a starting point.  I hope that you will be able to clone my repository and then make your own from there.

Please let me know if you get stuck in the install process (make a github issue) and I will try to help out.

# Installation on Windows
Note these install instructions assume that your vim directory is in: C:\opt\vim, modify as necessary.

### 1. Downlod the repository into your .vim folder

	git clone git://github.com/johndgiese/dotvim.git C:\opt\vim\.vim

### 2. Add some executables that are used by plugins
For some of the utilities (e.g. the ctags programs) to work, you will need to add the vimfiles\onpath 
directory to the windows PATH:

	setx PATH "%PATH%;C:\opt\vim\.vim\windows" -M

(Note: if you only want to add it to the current user's path, omit the -M)

### 3. Create symbolic links

	C:\opt\vim\.vim\setup.bat
	
You can also just navigate to the directory and double click the batch file.  It should prompt you for your install directory (make sure you include double quotes if you installed in Program Files or Program Files (x86)).  This does a few things:

1. Creates a symbolic link: vimfiles <==> .vim
2. Creates a symbolic link: .vim/vimrc <==> _vimrc
3. Initializes and updates the git submodules with the vim plugins

You may wonder why not just rename .vim vimfiles?  Well, by keeping it named .vim and linking to it, the repository will work also on linux and mac.  You may also wonder why not just copy vimrc up a directory and name it _vimrc?  Well, by moving it up a directory we would take it out of the repository, and would no longer be able to track changes.

Note that I don't use a gvimrc file, instead I use an if statement in my vimrc; this keeps all my settings in a single file.

### 4. Update a global variable in the vimrc
You need to update a single directory in your vimrc (the line is towards the top of the file)

### 5. Add any necessary dependencies for the vipy plugin
Finally, if you want to use the vipy plugin you will need to run another batch script, as described in the install instructions [here](https://github.com/johndgiese/vipy)

# Install instructions on Linux/Mac
... coming soon (I have tested it so it at least mostly works)
Note these install instructions assume that your vim directory is in: C:\opt\vim, modify as necessary.

### 1. Downlod the repository into your .vim folder

	git clone git://github.com/johndgiese/dotvim.git ~/.vim

### 2. Install ctags

Ctags is a program that parses your code and generates links between files.  Ctags is used by a few plugins that I have, and they will complain if you don't have them installed.  You can remove the plugins, but I reccomend trying to install ctags.  It is super useful.  You can read about it [here](http://ctags.sourceforge.net/)

### 3. Create a symbolic link to your vimrc

	n -s ~/.vim/vimrc ~/.vimrc
	
You may wonder why not just copy vimrc up a directory and name it .vimrc?  By moving it up a directory we would take it out of the repository, and would no longer be able to track changes.
Note that I don't use a gvimrc file, instead I use an if statement in my vimrc; this keeps all my settings in a single file.

### 4. Update a global variable in the vimrc
You need to update a single directory in your vimrc (the line is towards the top of the file)

### 5. Add any necessary dependencies for the vipy plugin
Finally, if you want to use the vipy plug, you will have to install a few additional dependencies as described [here](https://github.com/johndgiese/vipy)

# How this vim setup differs from normal vim

* Much better colorscheme.
* ESC in insert mode is now jk (quickly, one after another).  This mapping allows you to keep your hands still.
* Swaps the semicolon and colon, because you use colon a lot and almost never use semicolon
* F1 opens nerdtree
* F2 opens the ctag viewer
* F3 is the mini-buffer explorer
* F4 opens the gundo plugin
* The new <leader> key is , instead of /
* Searches (pressing / or ? in normal mode) now have \v prepended so that vim uses the verymagic mode (i.e. it uses normal python/perl regular expressions instead of its own version)
* ,/ clears search highlighting
* ,s (i.e. ,s) starts spell search
* ,v opens the vimrc (which auto runs upon saving)
* ,o opens the colorscheme file for easy updating
* ,h will highlight the colors of all hex keys
* ,g will do a google search on the current selection
* F11 will maximize the window
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
