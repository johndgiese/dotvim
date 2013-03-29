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
set numberwidth=3
set wrap linebreak


" BASE DIRECTORY
if has('win32') || has('win64')
    let g:DV=$HOME.'\vimfiles'
else
    let g:DV='~/.vim'
endif
let g:DV=expand(g:DV)


" PLUGINS
" Set everything so vundle can load
set nocompatible
autocmd!
filetype off
let &rtp.=','.g:DV.'/bundle/vundle'
call vundle#rc(g:DV.'/bundle/')
Bundle 'gmarik/vundle'

" Use Git inside vim
Bundle 'tpope/vim-fugitive.git'

" Conque Shell
Bundle 'vim-scripts/Conque-Shell'

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


Bundle 'johndgiese/vipy2'
"
" Use ipython inside vim
"Bundle 'johndgiese/vipy.git'
"let g:vipy_profile='david'
"let g:vipy_position='rightbelow'

" A fuzzy file finder-- really great just press CTRL-P!
Bundle 'kien/ctrlp.vim.git'
let g:ctrlp_cmd='CtrlPRoot'

" Snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"


" OTHER GOOD PLUGINS
" Uncomment and run BundleInstall! to use

" The solarized color theme
" Bundle 'altercation/vim-colors-solarized'
" let g:solarized_termcolors=256

" Save the vim state and reload when you come back
" Bundle 'xolox/vim-session.git'

" A nice indicator for git
" Bundle 'airblade/vim-gitgutter'

" Put in closing brackets automatically
" Bundle 'Townk/vim-autoclose.git'

" Syntax highlighting interface
" NOTE: to use it with various file-types you need to have the respective
" syntax program installed
" Bundle 'scrooloose/syntastic.git'
" nnoremap <leader>e :SyntasticCheck<CR>
" let g:locliststate=1
" let g:syntastic_enable_ballons=0
" let g:syntastic_enable_auto_jump=1
" let g:syntastic_enable_highlighting=1
" let g:syntastic_auto_loc_list=1
" let g:syntastic_mode_map = { 'mode': 'passive',
"                             \ 'active_filetypes': [], 
"                             \ 'passive_filetypes': [] }


"set backup
let &backupdir=g:DV."/tmp/backup"
if !isdirectory(g:DV."/tmp/backup")
    call mkdir(g:DV."/tmp/backup", 'p', 0755)
endif


" GOOGLE SEARCH
function! GoogleSearch()
    let searchterm = getreg("g")
    silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>

" MAPPINGS
" use comma instead of \ for leader, because it is easier to reach
let mapleader = ","

" better <ESC> (to go back to normal mode from insert mode)
inoremap jk <ESC>
inoremap <ESC> <nop>

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

" Remap block-visual mode to alt-V, and set paste-from-clipboard to C-v
nnoremap <A-v> <C-v>
nnoremap <C-v> "+gp
inoremap <C-v> <ESC>"+gpi
vnoremap <C-v> d"+p
vnoremap <C-c> "+y
vnoremap <C-x> "+ygvd

" Move between editor lines (instead of actual lines) when holding CTRL 
vnoremap j gj
vnoremap k gk
vnoremap $ g$
vnoremap ^ g^
vnoremap 0 g0
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^
nnoremap 0 g0

" convenience mappings for moving insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-0> <C-S-o>$
inoremap <C-9> <C-S-o>9

" making vim command line more like bash
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" buffer switching
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" window switching
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-h> <C-w>h
nnoremap <M-l> <C-w>l

" Highlight whitespace with <leader>w, and remove with <leader>W
nnoremap <leader>w :/\s\+$<CR>
nnoremap <leader>W :%s/\s\+$//e<CR><silent>:noh<CR>


" INSERT SNIPPETS
nnoremap <leader>t 0i*<ESC>"=strftime(" (%I:%M %p)")<CR>p
nnoremap <leader>T 0i## <ESC>gUU$"=strftime(" (%I:%M %p)")<CR>po<ESC>xxi
nnoremap <leader>d "=strftime("%a %b %d, %Y")<CR>
nnoremap <leader>D 0i# <ESC>"=strftime("%a %b %d, %Y (%I:%M %p)")<CR>po<ESC>xxi


" SPELLING
" toggle spell checking
nnoremap <silent> <leader>s :set spell!<CR>

" correct the current word and move to the next one using ,S
nnoremap <silent> <leader>S 1z=]s 
set spelllang=en_us " Set region to US English
let &spellfile=g:DV."/spell/en.latin1.add"


" EDIT CUSTOMIZATION
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

if !exists("autocommands_loaded")
    let autocommands_loaded=1

    " Rerun vimrc upon editing
    autocmd bufwritepost vimrc source %

    " update the colorscheme upon saving
    autocmd bufwritepost betterblack.vim :colorscheme betterblack
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

" General web stuff
au BufRead,BufNewFile *.json set filetype=json
au FileType htmldjango set ft=htmldjango.html


" OS DEPENDENT STUFF
if has('win32') || has('win64')
    " Swap the commented out lines if you want to install the better consolas
    " go to .vim/windows and double click the font files to install
    " set guifont=Consolas\ for\ Powerline\ FixedD:h10
    " set guifont=CodingFontTobi:h12
    set guifont=ProggyTinyTTSZ:h12
    " set guifont=Consolas:h10
    let g:Powerline_symbols='compatible'
elseif has('mac')
    let macvim_skip_cmd_opt_movement = 1
    let macvim_skip_colorscheme = 1
    let macvim_hig_shift_movement = 1
    set macmeta
    set noantialias
    set guifont=CodingFontTobi:h12,\ Monaco:h10
    let g:Powerline_symbols='compatible'
else
    set guifont=CodingFontTobi\ 12
    let g:Powerline_symbols='compatible'
endif

" Code that I only want to run once
if !exists('g:vimrc_has_run')
    let g:vimrc_has_run='True'
    syntax enable                   " turn syntax highlighting
    colorscheme betterblack
    if has('gui_running')
        set columns=130 lines=70
    endif
endif

