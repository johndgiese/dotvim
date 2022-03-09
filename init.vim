" GENERAL SETTINGS
set ruler
set secure
set hidden
set nonumber numberwidth=3 relativenumber
set wrap linebreak
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set breakindent

" set a more ergonomic escape
inoremap jk <ESC>
xnoremap jk <ESC>
cnoremap jk <ESC>
set timeoutlen=300

" switch semi-colon and colon
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" set a more ergonomic leader key
let mapleader = ","

" insert the very magic reg-ex mode every time
set hlsearch incsearch
nnoremap / /\v
nnoremap ? ?\v

" quickly clear search highlighting
nnoremap <silent> <leader>/ :noh<CR>

" disable Ex mode
nnoremap Q <nop>
vnoremap Q <nop>

" easier window switching
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-l> <C-\><C-N><C-w>l

" make terminal use my bash config
set shellcmdflag=-ic

" highlight trailing whitespace
nnoremap <leader>w :/\s\+$<CR>

" remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//e<CR><silent>:noh<CR>

" move between editor lines (instead of actual lines)
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

" quickly edit and source the vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" focus mode
nnoremap <silent> <leader>f :call FocusMode()<CR>

let g:focus_mode=0
function! FocusMode()
    if g:focus_mode
        let g:focus_mode=0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set number
        set relativenumber
        execute "normal! zE"
    else
        let g:focus_mode=1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set nonumber
        set norelativenumber
    end
endfunction

" toggle spell checking
nnoremap <silent> <leader>s :set spell!<CR>

" configure spell check language
set spelllang=en_us
" PLUGINS
call plug#begin(stdpath('data') . '/plugged')

" use git inside vim easily
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" file browsing
Plug 'scrooloose/nerdtree'
noremap <silent> <leader>1 :NERDTreeToggle<CR>

" buffer browsers/switcher
Plug 'jlanzarotta/bufexplorer'
let g:bufExplorerDefaultHelp=0
noremap <silent> <leader>3 :BufExplorer<CR>

" branching undo plugin
Plug 'sjl/gundo.vim'
let g:gundo_prefer_python3 = 1
let g:gundo_right = 1
let g:gundo_help = 0
nnoremap <silent> <leader>4 :GundoToggle<CR>

" ripgrep search integration
Plug 'jremmen/vim-ripgrep'
nnoremap <silent> <leader>g yaw:Rg <C-R>0<CR>

" make more commands work with repeat
Plug 'tpope/vim-repeat'

" handle word variants
Plug 'tpope/vim-abolish'

" visual selection search with # and *
Plug 'nelstrom/vim-visual-star-search'

" various mappings related to pairs
Plug 'tpope/vim-unimpaired'

" highlight colors
Plug 'chrisbra/Colorizer'
nnoremap <leader>c :ColorToggle<CR>

" vime tmux
Plug 'christoomey/vim-tmux-navigator'

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" fuzzy-file finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
nnoremap <C-p> :FZF<CR>

" status line
Plug 'vim-airline/vim-airline'
let g:airline_section_b = ''  " hide git branch
let g:airline_section_y = ''  " hide encoding
if !exists("g:airline_symbols")
    let g:airline_symbols = {}
end
let g:airline_symbols.colnr = ' '
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''

call plug#end()

" disable matching parenthesise when on a network file
autocmd BufReadPre //* :NoMatchParen

" color scheme
set t_Co=256
colorscheme betterblack
