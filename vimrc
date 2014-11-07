" GENERAL SETTINGS
set autoindent
set showmatch
set ruler
set laststatus=2
set backspace=indent,eol,start
set showmode
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set history=1000
set encoding=utf-8
set noswapfile
set hidden
set number numberwidth=3
set wrap linebreak
set nocompatible
let mapleader = ","

" allow scrolling in vim
set mouse=a

" keep vim from prompting when a file changes in the background, just re-read
" it; this is a contencious setting, make sure you know what it does
set autoread

" DIRECTORIES
if has('win32') || has('win64')
    let g:DV=$HOME.'\vimfiles'
else
    let g:DV=$HOME.'/.vim'
endif
let g:DV=expand(g:DV)

" backup
let &backupdir=g:DV."/tmp/backup"
if !isdirectory(g:DV."/tmp/backup")
    call mkdir(g:DV."/tmp/backup", 'p', 0755)
endif

" tags
let &tags=g:DV."/tmp/tags/"
if !isdirectory(g:DV."/tmp/tags")
    call mkdir(g:DV."/tmp/tags", 'p', 0755)
endif


" PLUGINS
" Set everything so vundle can load
autocmd!
filetype off
let &rtp.=','.g:DV.'/bundle/vundle'
call vundle#rc(g:DV.'/bundle/')
Bundle 'gmarik/vundle'

" Use Git inside vim easily
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-git.git'
nnoremap dp dp]c
nnoremap do do]c

" Move back and forth through commits while staying on the same line
nnoremap <A-right> :call GlogForward()<CR>
nnoremap <A-left> :call GlogBackward()<CR>

function! GlogForward()
    let l:line=line('.')
    try
        cnext
    catch /^Vim\%((\a\+)\)\=:E553/
        echo 'Already at the newest version'
    endtry
    call setpos('.', [0, l:line, 0, 0])
endfunction

function! GlogBackward()
    let l:line=line('.')
    try
        cprev
    catch /^Vim\%((\a\+)\)\=:E553/
        echo 'Already at the oldest version'
    endtry
    call setpos('.', [0, l:line, 0, 0])
endfunction

" Commenting tools
Bundle 'scrooloose/nerdcommenter.git'

" Lets you deal with braket pairs etc.
Bundle 'tpope/vim-surround.git'

" Autocomplete
Bundle 'Valloric/YouCompleteMe'

" Better javascript indenting etc.
Bundle 'pangloss/vim-javascript.git'

" Node.js tools
Bundle 'moll/vim-node'

" better yaml support
Bundle 'chase/vim-ansible-yaml'

" Arduino syntax highlighting
"Bundle "sudar/vim-arduino-syntax"

" extended matching with %
Bundle 'edsono/vim-matchit.git'

" make more commands work with repate
Bundle 'tpope/vim-repeat'

" handle word variants
Bundle 'tpope/vim-abolish'

" visual selection search with # and *
Bundle 'nelstrom/vim-visual-star-search'

" various mappings related to pairs
Bundle 'tpope/vim-unimpaired.git'

" colors can be highlighed using <leader>c
Bundle 'chrisbra/color_highlight'
nnoremap <leader>c <Plug>Colorizer<CR>

" less syntax highlighting
Bundle 'groenewege/vim-less'

" File browsing
Bundle 'scrooloose/nerdtree.git'
noremap <silent> <leader>1 :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\~$', '\.pyc']

" Ack search integration
Bundle 'mileszs/ack.vim.git'
let g:ack_default_options = " -H --nocolor --nogroup --column --smart-case --follow"

" Add Cdo and Ldo (similar to argdo but for the quickfix list)
Bundle 'Peeja/vim-cdo'

" Toggle quickfix and localist
Bundle 'milkypostman/vim-togglelist'

" Ctag viewer
Bundle 'majutsushi/tagbar.git'
let g:tagbar_iconchars = ['+', '-']
noremap <silent> <leader>2 :TagbarToggle<CR>

" Nice buffer browsers/switcher
Bundle 'corntrace/bufexplorer'
noremap <silent> <leader>3 :BufExplorer<CR>
let g:bufExplorerDefaultHelp=0

" Vim sugar for unix shell commands that need it
Bundle 'tpope/vim-eunuch.git'

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

" A better status line
Bundle 'Lokaltog/vim-powerline.git'
let g:Powerline_stl_path_style='relative'
let g:Powerline_symbols='compatible'

" A fuzzy file finder-- really great just press CTRL-P!
Bundle 'kien/ctrlp.vim.git'
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_extensions = ['dir']
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
    \ 'file': '\v\.(pyc)$',
    \ 'dir': '\v[\/](env|collected_static)$',
    \ }

" Snippets Plugin
" Note: snipmate has more snippets, but fewer features---I think ultisnips
" will win out pretty soon
Bundle "SirVer/ultisnips"
set runtimepath+=~/.vim/ultisnips_rep
nnoremap <leader>u :UltiSnipsEdit<CR>

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Syntax highlighting interface
Bundle 'scrooloose/syntastic.git'
let g:locliststate=1
let g:syntastic_enable_ballons=0
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=0
let g:syntastic_enable_auto_jump=1
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['cpp', 'c'],
                            \ 'passive_filetypes': ['python', 'javascript'] }

let g:syntastic_python_checkers=['flake8', 'pylint']
let g:syntastic_python_pylint_args = "--errors-only"

let g:syntastic_javascript_checkers=['jshint']

let g:syntastic_cpp_checkers=['gcc']

let g:syntastic_c_checkers=['gcc']


let g:syntastic_enable_highlighting=0
let g:syntastic_on=0
function! SyntasticToggle()
    let g:syntastic_enable_highlighting=g:syntastic_on
    SyntasticCheck
    if g:syntastic_on
        lclose
    end
    let g:syntastic_on=!g:syntastic_on
endfunction
nnoremap <silent> <leader>e :call SyntasticToggle()<CR>


" OTHER GOOD PLUGINS
" Uncomment and run BundleInstall! to use

" Conque Shell
" Bundle 'vim-scripts/Conque-Shell'

" The solarized color theme
" Bundle 'altercation/vim-colors-solarized'
" let g:solarized_termcolors=256

" Save the vim state and reload when you come back
" Bundle 'xolox/vim-session.git'

" A nice indicator for git
" Bundle 'airblade/vim-gitgutter'

" Put in closing brackets automatically
" Bundle 'Townk/vim-autoclose.git'


" GOOGLE SEARCH
function! GoogleSearch()
    let searchterm = getreg("g")
    silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>

" MAPPINGS

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

" disable Ex mode
nnoremap Q <nop>
vnoremap Q <nop>

" set paste toggle
set pastetoggle=<leader>p

" set make program shortcut
nnoremap <leader>5 :call Make()<CR>
vnoremap <leader>5 :call Make()<CR>

function! Make()
    make
    if !g:quickfix_open
        if (len(getqflist()) > 1)
            copen
            let g:quickfix_open=1
        end
    end
endfunction

" toggle fugivite status
let g:gstatus_open=0
function! GStatusToggle()
    if g:gstatus_open
        try
            bdelete index
            let g:gstatus_open=0
        catch
            Gstatus
            let g:gstatus_open=1
        endtry
    else
        Gstatus
        let g:gstatus_open=1
    end
endfunction
nnoremap <silent> <leader>6 :call GStatusToggle()<CR>

nnoremap <A-]> :cnext<CR>
nnoremap <A-[> :cprev<CR>

" Remap block-visual mode to alt-V, and set paste-from-clipboard to C-v
nnoremap <A-v> <C-v>
"nnoremap <C-v> "+gp
"inoremap <C-v> <ESC>"+gpi
"vnoremap <C-v> d"+p
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

" jumping to definitions

" goto definition
nnoremap gd <C-]>zz

" go back
nnoremap gb <C-t>

" see uses
nnoremap gu vawy:tselect <C-r>0<CR>

" making vim command line more like bash
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
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
" moving using M-direction
" open new windows ugin M-S-direction
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Highlight whitespace with <leader>w, and remove with <leader>W
nnoremap <leader>w :/\s\+$<CR>
nnoremap <leader>W :%s/\s\+$//e<CR><silent>:noh<CR>

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

" See what syntax groups are under the cursor
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

" General web stuff
au FileType htmldjango set ft=htmldjango.html

" Cscope stuff
if has("cscope")
    set csprg=/usr/local/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

" OS DEPENDENT STUFF
if has('win32') || has('win64')
    set guifont=Consolas:h10
elseif has('mac')
    let macvim_skip_cmd_opt_movement = 1
    let macvim_skip_colorscheme = 1
    let macvim_hig_shift_movement = 1
    set macmeta
    set noantialias
    set guifont=Monaco:h10
else
    set guifont=CodingFontTobi\ 12
endif

syntax enable
filetype plugin indent on

set t_Co=256
colorscheme betterblack
