set nocompatible                " vi compatible is LAME
autocmd!
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
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
syntax enable                   " turn syntax highlighting
set number		            	" turn on line numbers by default
set noignorecase
set history=100                 " remember the last 100 commands
colorscheme betterblack
if has('win32') || has('win64')
    set guifont=Consolas:h10
    " If you are cloning this file you need to update the next line to your
    " .vim directory
    let g:DV='C:\opt\vim\.vim'
else
    set guifont=Monospace\ 8
    let g:DV='~/.vim'
endif
set noswapfile
set hidden
let &directory=g:DV.'/tmp/swap'
let &backupdir=g:DV.'/tmp/backup'

" branching undo is new in vim 7.3
if v:version > 702
    let &undodir=g:DV.'/tmp/undo'
    set undofile
endif

" SUPERTAB
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
let g:SuperTabCrMapping = 1
autocmd FileType *
   \ if &omnifunc != '' |
   \   call SuperTabChain(&omnifunc, "<c-p>") |
   \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
   \ endif

" NETWORK
" Disable matching parenthesise when on a network file
autocmd BufReadPre //* :NoMatchParen

" SESSIONS AND PROJECTS
" Trigger file-explorer plugin Nerd tree
noremap <silent> <F1> :NERDTreeToggle<CR>
noremap <silent> <S-F2> :TlistToggle<CR>
noremap <silent> <F2> :TagbarToggle<CR>
noremap <silent> <F3> :BufExplorer<CR>
let Tlist_Use_Right_Window=1
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_directory = g:DV.'/tmp/session'
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


" WEB DEVELOPMENT
" better html/javascript syntax/indenting (see javascript plugin)
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" Some salesforce stuff
au BufRead,BufNewFile *.cls set filetype=apex
au BufRead,BufNewFile *.page set filetype=page
au BufRead,BufNewFile *.json set filetype=javascript

" Add google searching capability
function! GoogleSearch()
    let searchterm = getreg("g")
    silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>

if !exists("autocommands_loaded")
    let autocommands_loaded=1

    " This beauty remembers where you were the last time you edited the file, and returns to the same position.
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

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
endfunction

" VISUALIZATION STUFF
" Show EOL type and last modified timestamp, right after the filename
set numberwidth=3
set wrap linebreak
" TODO: make search use regular expressions by default
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

" SYNTASTIC
let g:syntastic_enable_signs=0
let g:syntastic_enable_ballons=0
let g:syntastic_enable_auto_jump=0
let g:syntastic_enable_highlighting=0
let g:syntastic_auto_loc_list=2
let g:syntastic_quiet_warnings=1
let g:syntastic_echo_current_error=0
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': [], 
                            \ 'passive_filetypes': [] }

" PYTHON and VIPY
let g:vipy_profile='test'

" INSERT MODE MAPPINGS
inoremap <C-0> <C-S-o>$
inoremap <C-9> <C-S-o>9

" ABBREVIATIONS
abbreviate jquery JQuery
abbreviate labview LabVIEW
abbreviate matlab MATLAB

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

" SETTINGS FOR GVIM
set guioptions-=m 		" remove menu bar
set guioptions-=T		" remove toolbar
set guioptions+=LlRrb   " remove all scrollbars
set guioptions-=LlRrb
set guioptions-=e
set noscrollbind
