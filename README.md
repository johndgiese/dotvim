# This is just a starting point...
I love vim because it is FAST, lightweight, powerful, works in the commandline, and is mostly OS independent. That being said, some of the default settings are no good, and there is a lot of missing functionality.  I have developed a set of customizations to vim that fix these problems and will allow you to sync your vim customizations across the major operating systems.

Everyone has their own tastes, and will probably want to customize their setup further, so my vimrc is just a starting point.  I hope that you will be able to fork my repository and customize your own from there!  By using my vimrc as a starting place, you will save yourself a good deal of unnecessary frustration and more quickly be able to harness the full power of vim.

Please let me know if you get stuck in the install process (make a github issue) and I will try to help out.

# Installation on Windows

Note: these instructions assume that you have git-scm installed (git-scm comes with curl--which Vundle requires to use!).

### 1. Check that the $HOME environment variable is set correctly

The simplest way to make sure vim finds your customization files is to put them in your $HOME directory, which is usually: C:\Users\Yourname\ .  You can check what the $HOME environment variable is in the command prompt:

    echo %HOME%

You can change the $HOME environment variable as follows:

    setx HOME "C:\Users\YourName"

When you are running the commands below, make sure to replace "YourName" everytime it occurs

### 2. Downlod the repository into the vimfiles folder

	git clone https://github.com/johndgiese/dotvim.git C:\Users\YourName\vimfiles

### 3. Create symbolic links in the command prompt

    mklink C:\Users\YourName\_vimrc C:\Users\YourName\vimfiles\vimrc
    mklink C:\Users\YourName\_gvimrc C:\Users\YourName\vimfiles\gvimrc

### 4. Add some scripts to the $PATH

	setx PATH "%PATH%;C:\Users\YourName\vimfiles\windows"
	
NOTE: if there is a warning about truncation after this command, then you will need to remove some directories from your $PATH (windows only allows 1024 characters!).
	
Now close the command prompt to reset the environment variables.

### 5. Run BundleInstall

Go into vim and execute:

    :BundleInstall

This should now download and install all the plugins! (note it may appear that there is an error on Vundle itself--this doesn't seem to matter)

### Optional

If any of the plugins give you trouble, you can comment them out in your vimrc and Vundle won't load them!

If your vimrc is installed in somewhere besides C:\Users\YourName then you may need to adjust a directory name towards the top of the vimrc file.

If you want to use powerline with fancy fonts, you will need to install a patched font.  I have my favorites stored in the fonts directoy, the ConsolasForPowerline is great on windows.  You can double click on each of them to install the fonts.  Read about this feature [here](http://enegue.com/consolas-font-in-vim-powerline-windows/).  After you are done installing the font, uncomment the lines towards the top of the vimrc

If you want to use the vipy plugin you will need to install ipython and pyzmq, and finally run another batch script, as described in the install instructions [here](https://github.com/johndgiese/vipy)

# Install instructions on Linux/Mac

### 1. Download the repository into your .vim folder

	git clone https://github.com/johndgiese/dotvim.git ~/.vim

### 2. Create a symbolic link to your vimrc

	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gimrc ~/.gvimrc

### 3. Run BundleInstall
Open vim and execute:

    :BundleInstall

This should now download and install all the plugins! (note it may appear that there is an error on Vundle itself--this doesn't seem to matter)

### Optional

Ctags is a program that parses your code and generates links between files.  Ctags is used by a few plugins that I have, and they will complain if you don't have them installed.  You can comment out the plugins in the vimrc file, but I reccomend trying to install ctags.  It is super useful.  You can read about it [here](http://ctags.sourceforge.net/)

    sudo get-apt install ctags

If you want to use the vipy plugin you will need to install ipython and pyzmq, and finally run another batch script, as described in the install instructions [here](https://github.com/johndgiese/vipy).  Basically it is:

    sudo apt-get update
    sudo apt-get install libzmq-dev
    sudo apt-get install python-zmq

If any of the plugins give you trouble, you can comment them out in your vimrc.

# How this vim setup differs from normal vim

The most important three changes are:

* ESC in insert mode is now jk (quickly, one after another)
* Swaps the semicolon and colon, because you use colon a lot and almost never use semicolon
* ,v opens the vimrc (which auto runs upon saving)

These three shorcuts will save you a lot of time, and keep your hands more comfortable when typing.  I believe one of the main benefits of vim is that it allows you to keep your hands on the keyboard so you can type more faster.

* The new leader key is , instead of /
* ,1 lets you browse files
* ,2 lets you view the structure of your file
* ,3 lets you see all the open buffers
* ,4 lets you navigate the undo history (required vim 7.3)
* Searches (pressing / or ? in normal mode) now have \v prepended so that vim uses the verymagic mode (i.e. it uses normal python/perl regular expressions instead of its own version)
* ,/ clears search highlighting
* ,s (i.e. ,s) starts spell search
* Much better colorscheme
* ,o opens the colorscheme file for easy updating if you use different languages
* ,g will do a google search on the current selection
* ,w will highlight whitespace at the ends of lines, and ,W will delete it.
* F11 will maximize the window (only on windows)
* Autocomplete uses TAB unless there is white space before the cursor
* Tabs are replaced with four spaces
* CTRL-P opens the super awesome fuzzy file browser (:h ctrlp for details)

The following other plugins are installed:
* Vundle - lets you manage plugins more easily (look in the bundle directory)
* Nerdtree - browse files inside vim
* Tagbar - view the structure of your files using ctags
* Gundo - graphical view of undo branches; see the [vimcast](http://vimcasts.org/episodes/undo-branching-and-gundo-vim/)
* Fugitive - use git inside vim!  See the [vimcasts](http://vimcasts.org/episodes/archive) about it.
* Surround - work better with parenthesis and other nesting structures.  Type :h surround
* Vipy - use ipython inside vim!  python code completion, etc. see [the repo](https://github.com/johndgiese/vipy/blob/master/README.md)
* Autoclose - autoclose parenthesis
* Snipmate - add snippets of commonly usedcode
* Session - save the window structure and files opened, for easy switching between projects
* Unimpaired - provides various mappings for operating with pairs
* Powerline - a colorful and useful statusline
* Csscolor - css color highlighting
* Tabular - for aligning stuff (see [this vimcast](http://vimcasts.org/episodes/aligning-text-with-tabular-vim/))
* Supertab - tab autocompletion
* CTRLp - lets you browse files really quickly
* ... a few other little ones

,5 is my universal "run file" key, and "SHIFT-,5" is my debug file key.  These are loose terms.  Here is a list of files and what ,5 does for each of them.
* python   -- ,5 runs file (in vipy plugin)
* xml      -- S-,5 formats using xmllint (requires xmllint)
* html     -- ,5 opens in a browser (requires xmllint)
* latex    -- ,5 converts to a dvi and opens it in a viewer (requires Miketex)
* c        -- ,5 compiles code with make (Linux only), S-,5 runs a.out
* markdown -- ,5 generates an html file with the same name (i.e. test.mkd -- > test.html) and then opens it in chrome (linux only, need markdown filter [sudo apt-get install markdown])

# Maintaining your repo
The structure of this vimrc setup allows easy cross platform use and easy updating of your plugins.  This comes at a cost of it being a little more complicated to maintain (but overall much faster and stable).  Here are a few notes that may help you.

### Commiting changes
If you modify your vimrc file you will likely want to commit these changes to your repository.  Do this like you would for any git repository:

	git add .
	git commit -m "brief description of changes"

finally, if you are hosting your vim setup online you would push to the remote repository:

	git push origin master
	
Note that you may need to update the origin url for the repo (google online if you don't know how to do this)

### Managing plugins
I use Vundle to manage plugins; it is much better than the default way.  Google online if you don't believe me.  Instructions on how to use it [here](https://github.com/gmarik/vundle).

### Updating the VIMRC
You can quickly update the vimrc by pressing ,v in normal mode.  When you save it, it will source the changes so that you can see the effects immediatly.  Note that this doesn't always work as expected, so you may have to fully reset vim to use this.

### Updating the Colorscheme
Everyone likes a different colorscheme, so you will probably want to make some updates to mine or change it completely.  To do this you can use type ,o to go staright to the file to start editing.  When in the file you can type ,h to see all the hex colors (only available in gvim).

If you want to change the name of the colorscheme, you will have to go into your vimrc file and change the name in two places: one for actually loading the colorscheme, and one for enabling the ,o shortcut.

See [this vimcast](http://vimcasts.org/episodes/creating-colorschemes-for-vim/) for details about colorschemes.
