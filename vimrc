" SETUP THE BASE DIRECTORY (referenced in some mappings)
if has('win32') || has('win64')
    " If you are cloning this file you need to update the next line to your
    " .vim directory
    let g:DV=$HOME.'\vimfiles'

    " Swap the commented out lines if you want to install the better consolas
    " go to .vim/windows and double click the font files to install
    " set guifont=Consolas\ for\ Powerline\ FixedD:h10
    " let g:Powerline_symbols='fancy'
    set guifont=Consolas:h10
    let g:Powerline_symbols='compatible'
elseif has('mac')
    " I don't know which mac font to use
    " set guifont=Monospace\ 8
    let g:DV='~/.vim'
    let g:Powerline_symbols='compatible'
else
    " set guifont=Inconsolata\ 12
    set guifont=CodingFontTobi\ 12
    let g:DV='~/.vim'
    let g:Powerline_symbols='compatible'
endif
let g:DV=expand(g:DV)
let mapleader = ","

" SETUP PLUGINS (AND THEIR SETTINGS) WITH VUNDLE
set nocompatible
autocmd!
filetype off
" All of my favorite plugins
let &rtp.=','.g:DV.'/bundle/vundle'
call vundle#rc(g:DV.'/bundle/')
" The plugin manager
Bundle 'gmarik/vundle'

" The solarized color theme
" Bundle 'altercation/vim-colors-solarized'
" let g:solarized_termcolors=256

" Use Git inside vim
Bundle 'tpope/vim-fugitive.git'

" Put in closing brackets automatically
" Bundle 'Townk/vim-autoclose.git'

" Commenting tools
Bundle 'scrooloose/nerdcommenter.git'

" Lets you deal with braket pairs etc.
Bundle 'tpope/vim-surround.git'

" Align code usint :Tab/someregexp
Bundle 'godlygeek/tabular.git'

" Better javascript indenting etc.
Bundle 'pangloss/vim-javascript.git'

" extended matching with %
Bundle 'edsono/vim-matchit.git'

" various mappings related to pairs
Bundle 'tpope/vim-unimpaired.git'

" colors are highlighted in css files
Bundle 'ap/vim-css-color.git'

" File browsing
Bundle 'scrooloose/nerdtree.git'
noremap <silent> <leader>1 :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\~$', '\.pyc']

" Ctag viewer
Bundle 'majutsushi/tagbar.git'
let g:tagbar_iconchars = ['+', '-']
noremap <silent> <leader>2 :TagbarToggle<CR>

" Nice buffer browsers/switcher
Bundle 'corntrace/bufexplorer'
noremap <silent> <leader>3 :BufExplorer<CR>
let g:bufExplorerDefaultHelp=0

" branching undo is new in vim 7.3
if v:version > 702
    let &undodir=g:DV."/tmp/undo"
    if !isdirectory(g:DV."/tmp/undo")
        call mkdir(g:DV."/tmp/undo", 'p', 0755)
    endif
    set undofile

    " Graphical interface for the vim's branching undo stuff
    Bundle 'sjl/gundo.vim.git'
    nnoremap <silent> <leader>4 :GundoToggle<CR>
    let g:gundo_right = 1
    let g:gundo_help  = 0
endif

" Save the vim state and reload when you come back
Bundle 'xolox/vim-session.git'
let g:session_autosave = 'no'
let g:session_autoload = 'no'


" Autocomplete using tab instead of <C-x><C-o>
Bundle 'ervandew/supertab.git'
set completeopt=longest,menuone
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1
autocmd FileType *
   \ if &omnifunc != '' |
   \   call SuperTabChain(&omnifunc, "<c-p>") |
   \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
   \ endif

" A better status line
if has('gui_running')
    Bundle 'Lokaltog/vim-powerline.git'
    let g:Powerline_stl_path_style='short'
endif

" Use ipython inside vim
Bundle 'johndgiese/vipy.git'
let g:vipy_profile='david'
let g:vipy_position='rightbelow'

" A fuzzy file finder-- really great just press CTRL-P!
Bundle 'kien/ctrlp.vim.git'
let g:ctrlp_cmd='CtrlPRoot'

" Syntax highlighting interface
" NOTE: to use it with various file-types you need to have the respective
" syntax program installed
Bundle 'scrooloose/syntastic.git'
nnoremap <leader>e :SyntasticCheck<CR>
let g:locliststate=1
let g:syntastic_enable_ballons=0
let g:syntastic_enable_auto_jump=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': [], 
                            \ 'passive_filetypes': [] }

" Snipmate provides lots of snippets
" Press <C-r><tab> to see potential completions!
" <tab> will expand
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"

" Fullscreen
if has('win32') || has('win64')
    noremap <F11> <ESC>:call libcallnr("gvimfullscreen.dll","ToggleFullScreen",0)<CR>
end

" GENERAL SETTINGS
colorscheme betterblack
filetype plugin indent on
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets
set ruler                       " show the cursor position all the time
set laststatus=2                
set backspace=indent,eol,start  " make that backspace key work the way it should
set showmode                    " show the current mode
set ts=4 sts=4 sw=4 expandtab   " default indentation settings
set number		            	" turn on line numbers by default
set noignorecase
set history=100                 " remember the last 100 commands
set encoding=utf-8 
set noswapfile
set hidden
let loaded_matchparen = 1       " I find that the match parenthesis standard plugin is slow

"set backup
let &backupdir=g:DV."/tmp/backup"
if !isdirectory(g:DV."/tmp/backup")
    call mkdir(g:DV."/tmp/backup", 'p', 0755)
endif

" Code that I only want to run once
if !exists('g:vimrc_has_run')
    let g:vimrc_has_run='True'
    syntax enable                   " turn syntax highlighting
    colorscheme betterblack
    if has('gui_running')
        set columns=130 lines=50
    endif
endif


" NETWORK
" Disable matching parenthesise when on a network file
autocmd BufReadPre //* :NoMatchParen


" WEB DEVELOPMENT
" better html/javascript syntax/indenting (see javascript plugin)
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" Some salesforce stuff
au BufNewFile,BufRead *.less set filetype=less
au BufRead,BufNewFile *.cls set filetype=apex
au BufRead,BufNewFile *.page set filetype=page
au BufRead,BufNewFile *.json set filetype=json

" GOOGLE SEARCH
function! GoogleSearch()
    let searchterm = getreg("g")
    silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>

if !exists("autocommands_loaded")
    let autocommands_loaded=1

    " Rerun vimrc upon editing
    autocmd bufwritepost vimrc source %

    " update the colorscheme upon saving
    autocmd bufwritepost betterblack.vim :colorscheme betterblack
endif

" CUSTOM KEYCOMMANDS
" The first three blocks of mappings are the most 'important' they are 
" setup for speed and minimal finger movement

" Better <ESC> (to go back to normal mode from insert mode)
inoremap jk <ESC>
inoremap <ESC> <nop>
noremap <C-s> :w<CR>

" switch semi-colon and colon
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" insert the very magic reg-ex mode every time
set hlsearch incsearch
nnoremap / /\v
nnoremap ? ?\v
nnoremap <silent> <leader>/ :noh<CR>

" use comma instead of \ for leader, because it is closer
map \ ,

" Remap block-visual mode to alt-V, and set paste-from-clipboard to C-v
nnoremap <A-v> <C-v>
nnoremap <C-v> "+gp
inoremap <C-v> <ESC>"+gpi
vnoremap <C-v> d"+p
vnoremap <C-c> "+y
vnoremap <C-x> "+ygvd

" Move between editor lines (instead of actual lines) when holding CTRL 
vmap <C-j> gj
vmap <C-k> gk
vmap <C-4> g$
vmap <C-6> g^
vmap <C-0> g0
nmap <C-j> gj
nmap <C-k> gk
nmap <C-4> g$
nmap <C-6> g^
nmap <C-0> g0

" convenience mappings for moving insert mode
imap <C-h> <left>
imap <C-l> <right>

" buffer switching
nnoremap <M-j> :bn<CR>
nnoremap <M-k> :bp<CR>

" Highlight whitespace with <leader>w, and remove with <leader>W
nnoremap <leader>w :/\s\+$<CR>
nnoremap <leader>W :%s/\s\+$//e<CR><silent>:noh<CR>

" Insert Data
nnoremap <leader>t 0i*<ESC>"=strftime(" (%I:%M %p)")<CR>p
nnoremap <leader>T 0i## <ESC>gUU$"=strftime(" (%I:%M %p)")<CR>po<ESC>xxi
nnoremap <leader>d "=strftime("%a %b %d, %Y")<CR>
nnoremap <leader>D 0i# <ESC>"=strftime("%a %b %d, %Y (%I:%M %p)")<CR>po<ESC>xxi

" Toggle spell checking on and off with ,s
" correct the current word and move to the next one using ,S
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap <silent> <leader>S 1z=]s 
set spelllang=en_us " Set region to US English
let &spellfile=g:DV."/spell/en.latin1.add"

" Start editing the vimrc in a new buffer
nnoremap <leader>v :call Edit_vimrc()<CR>
function! Edit_vimrc()
    exe 'edit ' . g:DV . '/vimrc'
endfunction

" Edit your colorscheme on the fly!
nnoremap <leader>o :call Edit_colorscheme()<CR>
function! Edit_colorscheme()
    exe 'edit ' . g:DV . '/colors/betterblack.vim'
endfunction

nnoremap <leader>O :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" VISUALIZATION STUFF
" Show EOL type and last modified timestamp, right after the filename
set numberwidth=3
set wrap linebreak

" INSERT MODE MAPPINGS
inoremap <C-0> <C-S-o>$
inoremap <C-9> <C-S-o>9

" ABBREVIATIONS
abbreviate jquery JQuery
abbreviate labview LabVIEW
abbreviate matlab MATLAB

" testing

autocmd BufWriteCmd *.html :call Refresh_browser()
function! Refresh_browser()
    if &modified
        write
        silent !xdotool search --class google-chrome key ctrl+r
    endif
endfunction
