set nocompatible                " vi compatible is LAME
autocmd!
filetype off
if has('win32') || has('win64')
    " If you are cloning this file you need to update the next line to your
    " .vim directory
    let g:DV='C:\opt\vim\.vim'

    " Swap the comment out lines if you don't want to install better consolas
    " if you want to update your fonts, go to .vim/windows and double click
    " all of the font files there to install them
    set guifont=Consolas\ for\ Powerline\ FixedD:h10
    let g:Powerline_symbols='fancy'
    " set guifont=Consolas:h10
    " let g:Powerline_symbols = 'compatible'
elseif has('mac')
    " I don't know which mac font to use
    " set guifont=Monospace\ 8
    let g:DV='~/.vim'
    let g:Powerline_symbols='compatible'
else
    set guifont=Inconsolata\ 11
    let g:DV='~/.vim'
    let g:Powerline_symbols='fancy'
endif

" All of my favorite plugins
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'altercation/vim-colors-solarized'
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive.git'
Bundle 'Townk/vim-autoclose.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'tpope/vim-surround.git'
Bundle 'vim-scripts/taglist.vim.git'
Bundle 'pangloss/vim-javascript.git'
Bundle 'edsono/vim-matchit.git'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'vim-scripts/greplace.vim'
Bundle 'ap/vim-css-color.git'

Bundle 'sjl/gundo.vim.git'
nnoremap <silent> <F4> :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_help  = 0

Bundle 'scrooloose/nerdtree.git'
noremap <silent> <F1> :NERDTreeToggle<CR>

Bundle 'corntrace/bufexplorer'
noremap <silent> <F3> :BufExplorer<CR>
let g:bufExplorerDefaultHelp=0

Bundle 'xolox/vim-session.git'
let g:session_autosave = 'no'
let g:session_autoload = 'no'

Bundle 'godlygeek/tabular.git'
noremap <silent> <S-F2> :TlistToggle<CR>
let Tlist_Use_Right_Window=1

Bundle 'majutsushi/tagbar.git'
noremap <silent> <F2> :TagbarToggle<CR>

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

Bundle 'Lokaltog/vim-powerline.git'
let g:Powerline_stl_path_style='short'

Bundle 'johndgiese/vipy.git'
let g:vipy_profile='david'
let g:vipy_position='vertical'

Bundle 'kien/ctrlp.vim.git'
let g:ctrlp_cmd='CtrlPRoot'

Bundle 'scrooloose/syntastic.git'
nnoremap <leader>e :SyntasticToggleMode()<CR>

let g:locliststate=1
let g:syntastic_enable_ballons=0
let g:syntastic_enable_auto_jump=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': [], 
                            \ 'passive_filetypes': [] }

" Snipmate and three dependencies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"
let g:snips_trigger_key='<c-space>'

filetype plugin indent on
filetype plugin on
let mapleader = ","
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets
set vb                          " turn on the "visual bell" - quieter than the "audio blink"
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

"set backup
"let &backupdir=g:DV."/tmp/backup"
"call mkdir(backupdir, 'p')

" Code that I only want to run once
if !exists('g:vimrc_has_run')
    let g:vimrc_has_run='True'
    syntax enable                   " turn syntax highlighting
    set background=light
    let g:solarized_termcolors=256
    colorscheme solarized
    " colorscheme betterblack
endif

" branching undo is new in vim 7.3
if v:version > 702
    let &undodir=g:DV."/tmp/undo"
    set undofile
endif

" NETWORK
" Disable matching parenthesise when on a network file
autocmd BufReadPre //* :NoMatchParen

" Fullscreen
noremap <F11> <ESC>:call libcallnr("gvimfullscreen.dll","ToggleFullScreen",0)<CR>

" WEB DEVELOPMENT
" better html/javascript syntax/indenting (see javascript plugin)
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" Some salesforce stuff
au BufNewFile,BufRead *.less set filetype=less
au BufRead,BufNewFile *.cls set filetype=apex
au BufRead,BufNewFile *.page set filetype=page
au BufRead,BufNewFile *.json set filetype=javascript

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
" use comma instead of \ for leader, because it is closer
map \ ,

" insert the very magic reg-ex mode every time
set hlsearch incsearch
nnoremap / /\v
nnoremap ? ?\v
nnoremap <silent> <leader>/ :noh<CR>

" switch semi-colon and colon
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Remap block-visual mode to alt-V, and set paste-from-clipboard to C-v
nnoremap <A-v> <C-v>
nnoremap <C-v> "*p<CR>
inoremap <C-v> <ESC>"*p<CR>i
vnoremap <C-v> d"*p<CR>
nnoremap <C-c> "*y<CR>
inoremap <C-c> <ESC>"*y<CR>
vnoremap <C-c> "*y<CR>

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

" buffer switching
inoremap <C-tab> <ESC>:bn<CR>
inoremap <C-S-tab> <ESC>:bp<CR>
nnoremap <C-tab> :bn<CR>
nnoremap <C-S-tab> :bp<CR>
vnoremap <C-tab> <ESC>:bn<CR>
vnoremap <C-S-tab> <ESC>:bp<CR>

" Highlight whitespace with <leader>w, and remove with <leader>W
nnoremap <leader>w :/\s\+$<CR>
nnoremap <leader>W :%s/\s\+$//e<CR><silent>:noh<CR>

" Insert Data
nnoremap <leader>t "=strftime(" (%I:%M %p)")<CR>p
nnoremap <leader>T 0i## <ESC>gUU$"=strftime(" (%I:%M %p)")<CR>po<ESC>xxi
nnoremap <leader>d "=strftime("%a %b %d, %Y")<CR>
nnoremap <leader>D 0i# <ESC>"=strftime("%a %b %d, %Y (%I:%M %p)")<CR>po<ESC>xxi

" Toggle spell checking on and off with `,s`
nnoremap <silent> <leader>s :set spell!<CR>
set spelllang=en_us " Set region to US English

" Better <ESC> (to go back to normal mode from insert mode)
inoremap jk <ESC>
inoremap <ESC> <nop>
noremap <C-s> :w<CR>

" Start editing the vimrc in a new buffer
nnoremap <leader>v :call Edit_vimrc()<CR>
function! Edit_vimrc()
    exe 'edit ' . g:DV . '/vimrc'
endfunction
nnoremap <leader>o :call Edit_colorscheme()<CR>
function! Edit_colorscheme()
    exe 'edit ' . g:DV . '/colors/betterblack.vim'
    exe 'source ' . g:DV . '/bundle/csscolor/after/css.vim'
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

" SOME GIT SPECIFIC SETTINGS
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")

" SETTINGS FOR GVIM
if has('gui_running')
    set guioptions-=m 		" remove menu bar
    set guioptions-=T		" remove toolbar
    set guioptions+=LlRrb   " remove all scrollbars
    set guioptions-=LlRrb
    set guioptions-=e
    set noscrollbind
endif
