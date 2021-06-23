# This is just a starting point...

I started using Vim in graduate school. Years later, as the CEO of a growing [medical-device software development firm](https://innolitics.com), I still use Vim---or now Neovim---nearly every day.

I love Vim because it's fast, free, customizable, portable, mouse-minimal and multilingual. I like staying close to the text. Furthermore, since it's popular and open source, I feel comfortable investing to learn it without worrying that it will stop being supported in the future. Finally, if I want to use a new programming language, Vim will likely support sooner than the IDEs will.

Vim has downsides too: It's hard to learn, configuration maintenance can be annoying and disruptive, there's no graphical debugger, and advanced refactoring support isn't great. I use JetBrains' IDEs when I need a graphical debugger or advanced refactoring support, but I hope Neovim 0.5 will reduce the need for this.

My Neovim config is stored in this repository.

You'll likely want to adjust my settings, thus these files provide a nice starting point. I hope that you will be able to fork my repository and customize your own from there! Using my vimrc as a starting place may save you some time.

Let me know if you get stuck in the install process (make a GitHub issue) and I'll try to help out.

# Installation

If you use macOS or Linux, run these commands:

	git clone git@github.com:johndgiese/dotvim.git ~/.config/nvim
    sh ~/.config/nvim/install.sh

## Ctags

Ctags creates an index of language objects in your code. A few of my vim plugins rely on this index. You can comment out the plugins in init.vim, but I recommend trying to install ctags. It's quite useful. You can read about it [here](https://docs.ctags.io/en/latest/).

To install it on Ubuntu, run this command:

    sudo apt-get install ctags

To install it on macOS, run this command:
  
    # see https://docs.ctags.io/en/latest/osx.html#building-with-homebrew
    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags

## Fzf and Rip-grep

Fzf is a fuzzy file finder and rip-grep is a fast file-search tool.

To install it on macOS, run this command:

    brew install ripgrep fzf

To install it on Ubuntu (18.10 and newer), run this command:

    sudo apt-get install ripgrep

# How this vim config differs from normal vim

The most important three changes are:

* ESC in insert mode is now jk (quickly, one after another)
* Swaps `;` and `:`, because you use `:` all the time in vim but rarely use `;`
* The new \<leader\> key is `,` instead of `/`

These three shortcuts will save you a lot of keypresses and keep your hands comfortable during long days of coding.

* \<leader\>ev opens the vimrc
* \<leader\>sv sources the vimrc (which you need to make changes come into effect)
* \<leader\>1 lets you browse files
* \<leader\>2 lets you view the structure of your file
* \<leader\>3 lets you see all the open buffers
* \<leader\>4 lets you navigate the undo history
* \<leader\>5 runs your make program, which is file-type dependent (see below)
* \<leader\>6 toggles the fugitive Gstatus buffer
* Searches (pressing / or ? in normal mode) now have \v prepended so that vim uses the verymagic mode (i.e. it uses normal python/perl regular expressions instead of its own version)
* \<leader\>/ clears search highlighting
* \<leader\>s toggles spell-check
* Much better colorscheme
* \<leader\>o opens the colorscheme file for easy updating if you use different languages
* \<leader\>O shows the syntax groups below the cursor
* \<leader\>c toggles color highlighting
* \<leader\>w will highlight whitespace at the ends of lines, and ,W will delete it.
* \<leader\>e toggles syntastic plugin (see below) on and off
* \<leader\>q toggles the quickfix open and closed, and \<A-]\> and \<A-]\>
  navigates through the list
* \<C-p\> opens the a fuzzy file browser

The following other plugins are installed:
* vim-plug - lets you manage plugins more easily (look in the bundle directory)
* Nerdtree - browse files inside vim
* Tagbar - view the structure of your files using ctags
* Gundo - graphical view of undo branches; see the [vimcast](http://vimcasts.org/episodes/undo-branching-and-gundo-vim/)
* Fugitive - use git inside vim! See the [vimcasts](http://vimcasts.org/episodes/archive) about it.
* Colorizer - show colors within the editor (useful for CSS editing)
* Surround - work better with parenthesis and other nesting structures. Type :h surround
* Unimpaired - provides various mappings for operating with pairs
* Airline - a colorful and useful statusline
* FZF - lets you browse files really quickly
* ... a few other little ones

# Maintaining your repo

The structure of this vimrc setup allows easy cross platform use and easy updating of your plugins.  This comes at a cost of it being a little more complicated to maintain (but overall much faster and stable).  Here are a few notes that may help you.

## Commiting changes

If you modify your vimrc file you will likely want to commit these changes to your repository.  Do this like you would for any git repository

	git add .
	git commit -m "brief description of changes"

finally, if you are hosting your vim setup online you would push to the remote repository:

	git push origin master
	
Note that you may need to update the origin url for the repo (Google online if you don't know how to do this)

## Managing plugins

I use vim-plug to manage plugins; it is much better than the default way.  Google online if you don't believe me.  Instructions on how to use it [here](https://github.com/junegunn/vim-plug).

## Updating the VIMRC

You can quickly update the vimrc by pressing \<leader\>v in normal mode.  When you save it, it will source the changes so that you can see the effects immediately.  Note that this doesn't always work as expected, so you may have to fully reset vim to use this.

## Updating the Colorscheme

Everyone likes a different colorscheme, so you will probably want to make some updates to mine or change it completely.  To do this you can use type \<leader\>o to go straight to the file to start editing.  You can use \<leader\>O to see what syntax groups below the cursor.

If you want to change the name of the colorscheme, you will have to go into your vimrc file and change the name in two places: one for actually loading the colorscheme, and one for enabling the ,o shortcut.

See [this vimcast](http://vimcasts.org/episodes/creating-colorschemes-for-vim/) for details about colorschemes.
