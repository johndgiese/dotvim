" TODO: add jslint and csslint
" TODO: add smart commenting
" TODO: add reference for HTML, CSS
" TODO: add pydoc
" TODO: add function to start debuging file in IPython
" TODO: check that I am using autocommands correctly
" TODO: add execute selection (in Pylab)
" TODO: update autocomplete for CSS3 and HTML5
" TODO: add python rope (autocomplete)
" TODO: make a better status line
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
let mapleader = ","
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets
set vb                          " turn on the "visual bell" - quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set showmode                    " show the current mode
set ts=4 sts=4 sw=4 expandtab   " default indentation settings
syntax enable                   " turn syntax highlighting
set number		            	" turn on line numbers by default
set noignorecase
set history=100                 " remember the last 100 commands
colorscheme betterblack
set directory=C:\\opt\\vim\\tmp\\swap
set backupdir=C:\\opt\\vim\\tmp\\backup
set undofile
set undodir=C:\\opt\\vim\\tmp\\undo
set hidden
if has('win32') || has('win64')
    set guifont=Consolas:h10
    let $DV='C:\opt\vim\.vim'
else
    let $DV='~/.vim'
endif

" SUPERTAB
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabNoCompleteBefore = []
let g:SuperTabNoCompleteAfter = []
let g:SuperTabMappingForward = '<C-space>'
let g:SuperTabMappingBackward = '<S-C-space>'
let g:SuperTabCrMapping = 1
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
    \ endif

" SESSIONS AND PROJECTS
" Trigger file-explorer plugin Nerd tree
noremap <silent> <F1> :NERDTreeToggle<CR>
noremap <silent> <S-F2> :TlistToggle<CR>
noremap <silent> <F2> :TagbarToggle<CR>
noremap <silent> <F3> :BufExplorer<CR>
let Tlist_Use_Right_Window=1
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_directory = expand($VIM) . "\\tmp\\session"
" Gundo plugin
nnoremap <silent> <F4> :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_help  = 0
" bufexplorer plugin
let g:bufExplorerDefaultHelp=0
" Fullscreen
noremap <F11> <ESC>:call libcallnr("gvimfullscreen.dll","ToggleFullScreen",0)<CR>


" show syntax highlighting groups for word under cursor
nnoremap <C-S-p> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

filetype plugin indent on
filetype plugin on

" WEB DEVELOPMENT
au BufRead,BufNewFile *.cls set filetype=apex
au BufRead,BufNewFile *.page set filetype=page
au BufRead,BufNewFile *.json set filetype=javascript
function! GoogleSearch()
    let searchterm = getreg("g")
    silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>

" PYTHON SETTINGS
nnoremap <leader>r :!start ipython --pdb % <CR><CR>
if !exists("autocommands_loaded")
    let autocommands_loaded=1
" disable pylint warnings
let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0212,W0221,W0223,W0232,W0401,W0613,W0631,E1101,E1120,R0903,R0904,R0913'

    " This beauty remembers where you were the last time you edited the file, and returns to the same position.
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Rerun vimrc upon editing
    autocmd bufwritepost vimrc source $DV\vimrc

    " update the colorscheme upon saving
    autocmd bufwritepost betterblack.vim :colorscheme betterblack
endif

" CUSTOM KEYCOMMANDS
" use comma instead of \ for leader, because it is closer
map \ ,
" switch semi-colon and colon
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Remap block-visual mode to alt-V, and set paste-from-clipboard to C-v
nnoremap <A-v> <C-v>
nnoremap <C-v> "*p<CR>
inoremap <C-v> <ESC>"*p<CR>
vnoremap <C-v> d"*p<CR>
nnoremap <C-c> "*y<CR>
inoremap <C-c> <ESC>"*y<CR>
vnoremap <C-c> "*y<CR>

" Move between editor lines (instead of actual lines) when holding CTRL 
vmap <C-j> gj
vmap <C-k> gk
vmap <C-4> g$
vmap <C-6> g^
vmap <C-0> g^
nmap <C-j> gj
nmap <C-k> gk
nmap <C-4> g$
nmap <C-6> g^
nmap <C-0> g^

" Highlight whitespace with <leader>w, and remove with <leader>W
nnoremap <leader>w :/\s\+$<CR>
nnoremap <leader>W :%s/\s\+$//e<CR><silent>:noh<CR>

" Insert Data
nnoremap <leader>t "=strftime(" %I:%M %p")<CR>p
nnoremap <leader>T 0i## <ESC>gUU$"=strftime(" (%I:%M %p)")<CR>po<ESC>xxi
nnoremap <leader>d "=strftime("%a %b %d, %Y")<CR>
nnoremap <leader>D 0i# <ESC>"=strftime("%a %b %d, %Y (%I:%M %p)")<CR>po<ESC>xxi

" Toggle spell checking on and off with `,s`
nnoremap <silent> <leader>s :set spell!<CR>
set spelllang=en_us " Set region to US English

" Better <ESC> (to go back to normal mode from insert mode)
inoremap jk <ESC>
inoremap kj <ESC>
inoremap <ESC> <nop>
noremap <C-s> :w<CR>

" Start editing the vimrc in a new buffer
nnoremap <leader>v :e $DV\vimrc<CR>
nnoremap <leader>o :e $DV\colors\betterblack.vim<CR>

" VISUALIZATION STUFF
" Show EOL type and last modified timestamp, right after the filename
set numberwidth=3
set hlsearch incsearch
set wrap linebreak
" TODO: make search use regular expressions by default
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

" AUTOCOMPLETE
set completeopt=longest,menuone

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
