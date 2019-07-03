" GENERAL SETTINGS
set autoindent
set showmatch
set ruler
set exrc
set secure
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
    let g:rcroot=$HOME.'\vimfiles'
else
    let g:rcroot=$HOME.'/.vim'
endif
let g:rcroot=expand(g:rcroot)

" backup
let &backupdir=g:rcroot."/tmp/backup"
if !isdirectory(g:rcroot."/tmp/backup")
    call mkdir(g:rcroot."/tmp/backup", 'p', 0755)
endif

" tags
let &tags=g:rcroot."/tmp/tags/"
if !isdirectory(g:rcroot."/tmp/tags")
    call mkdir(g:rcroot."/tmp/tags", 'p', 0755)
endif


" PLUGINS
" Set everything so vundle can load
autocmd!
filetype off
let &rtp.=','.g:rcroot.'/bundle/Vundle.vim'
call vundle#begin(g:rcroot.'/bundle')
Plugin 'gmarik/Vundle.vim'

" Use Git inside vim easily
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-git.git'
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
Plugin 'scrooloose/nerdcommenter.git'

" Lets you deal with braket pairs etc.
Plugin 'tpope/vim-surround.git'

" Adds indent objects
Plugin 'michaeljsmith/vim-indent-object'

" Autocomplete
Plugin 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" Better javascript indenting etc.
Plugin 'pangloss/vim-javascript.git'
Plugin 'leafgarland/typescript-vim.git'
autocmd BufNewFile,BufFilePre,BufRead *.tsx set filetype=typescript
autocmd BufNewFile,BufFilePre,BufRead *.ts set filetype=typescript

" JSX Support
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0

" Coffee script support
Plugin 'kchmck/vim-coffee-script'

" Jinja template syntax
Plugin 'Glench/Vim-Jinja2-Syntax'

" Sass syntax
Plugin 'cakebaker/scss-syntax.vim'

" Rust syntax
Plugin 'rust-lang/rust.vim'
au BufRead,BufNewFile *.rs set ft=rust

" Node.js tools
Plugin 'moll/vim-node'

" make more commands work with repate
Plugin 'tpope/vim-repeat'

" handle word variants
Plugin 'tpope/vim-abolish'

" visual selection search with # and *
Plugin 'nelstrom/vim-visual-star-search'

" various mappings related to pairs
Plugin 'tpope/vim-unimpaired.git'

" colors can be highlighed using <leader>c
Plugin 'chrisbra/Colorizer'
nnoremap <leader>c :ColorToggle<CR>

" filetypes
Plugin 'groenewege/vim-less'
Plugin 'peterhoeg/vim-qml'
au BufRead,BufNewFile *.qml set ft=qml

Plugin 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" File browsing
Plugin 'scrooloose/nerdtree.git'
noremap <silent> <leader>1 :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\~$', '\.pyc', '__pycache__', '\.qmlc', '\.jsc']
let NERDTreeMapHelp = '<f1>'


" Ack search integration
Plugin 'mileszs/ack.vim.git'
let g:ackprg = 'ag --noheading --nocolor --nogroup --column --smart-case --follow --nobreak --silent'

" Add Cdo and Ldo (similar to argdo but for the quickfix list)
Plugin 'Peeja/vim-cdo'

" Toggle quickfix and localist
Plugin 'milkypostman/vim-togglelist'

" Ctag viewer
Plugin 'majutsushi/tagbar.git'
let g:tagbar_iconchars = ['+', '-']
noremap <silent> <leader>2 :TagbarToggle<CR>

" Nice buffer browsers/switcher
Plugin 'ivegotasthma/bufexplorer'
noremap <silent> <leader>3 :BufExplorer<CR>
let g:bufExplorerDefaultHelp=0

" Vim sugar for unix shell commands that need it
Plugin 'tpope/vim-eunuch.git'

" branching undo is new in vim 7.3
if v:version > 702
    let &undodir=g:rcroot."/tmp/undo"
    if !isdirectory(g:rcroot."/tmp/undo")
        call mkdir(g:rcroot."/tmp/undo", 'p', 0755)
    endif
    set undofile

    " Graphical interface for the vim's branching undo stuff
    Plugin 'sjl/gundo.vim.git'
    nnoremap <silent> <leader>4 :GundoToggle<CR>
    let g:gundo_right = 1
    let g:gundo_help  = 0
endif

" Tmux vim bindings
Plugin 'christoomey/vim-tmux-navigator'

" A better status line
Plugin 'itchyny/lightline.vim'

" A fuzzy file finder
Plugin 'kien/ctrlp.vim.git'
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_extensions = ['dir']
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_user_command = {
\ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
  \ },
\ 'fallback': 'find %s -type f',
\ 'ignore': 1
\ }

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
nnoremap <leader>u :UltiSnipsEdit<CR>
let g:UltiSnipsSnippetsDir = g:rcroot.'/mysnippets/'
let g:UltiSnipsSnippetDirectories = ["mysnippets", "UltiSnips"]
autocmd BufNewFile,BufRead *.snippets set filetype=snippets

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

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif
  return ""
endfunction

if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" Bracketed Paste
Plugin 'ConradIrwin/vim-bracketed-paste'

" Syntax highlighting interface
Plugin 'scrooloose/syntastic.git'
let g:syntastic_enable_ballons=0
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_signs=1
let g:syntastic_enable_auto_jump=0
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['cpp', 'c', 'python', 'typescript'],
                            \ 'passive_filetypes': ['javascript'] }

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_typescript_checkers=['tslint']

let g:syntastic_cpp_checkers=['clang++']
let g:syntastic_c_checkers=['clang']


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


" MAPPINGS

" better <ESC> (to go back to normal mode from insert mode)
inoremap jk <ESC>
xnoremap jk <ESC>
cnoremap jk <ESC>
set timeoutlen=300

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
set pastetoggle=<F1>

" tool to build up "file traces" when debugging
vnoremap <C-m> :call CopyTraceAbove()<CR>

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! CopyTraceAbove()
    let trace = expand('%') . ':' . line('.') . ' ' . s:get_visual_selection()
    execute "normal! \<C-w>ko" . trace . "\<ESC>\<C-w>j"
endfunction

 " set make program shortcut
nnoremap <leader>5 :call Make()<CR>
vnoremap <leader>5 :call Make()<CR>

let g:quickfix_open=0
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
nnoremap gd :YcmCompleter GoTo<CR>

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
        execute "normal! zE"
    else
        let g:focus_mode=1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set nonumber
        execute "0;/^---$/ fold"
    end
endfunction

" SPELLING
" toggle spell checking
nnoremap <silent> <leader>s :set spell!<CR>

" correct the current word and move to the next one using ,S
nnoremap <silent> <leader>S 1z=]s
set spelllang=en_us " Set region to US English
let &spellfile=g:rcroot."/spell/en.latin1.add"


" EDIT CUSTOMIZATION
" Start editing the vimrc in a new buffer
nnoremap <leader>v :call Edit_vimrc()<CR>
function! Edit_vimrc()
    exe 'edit ' . g:rcroot . '/vimrc'
endfunction

" Edit your colorscheme on the fly!
nnoremap <leader>o :call Edit_colorscheme()<CR>
function! Edit_colorscheme()
    exe 'edit ' . g:rcroot . '/colors/betterblack.vim'
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
au BufRead,BufNewFile Vagrantfile set ft=ruby
au BufRead,BufNewFile *.coffee set ft=coffee
au BufRead,BufNewFile *.snippets set ft=snippets
au BufRead,BufNewFile Jenkinsfile set ft=groovy

" Crontab
autocmd filetype crontab setlocal nobackup nowritebackup

" OS DEPENDENT STUFF
if has('win32') || has('win64')
    set guifont=Consolas:h10
elseif has('mac')
    let macvim_skip_cmd_opt_movement = 1
    let macvim_skip_colorscheme = 1
    let macvim_hig_shift_movement = 1
    if exists("&macmeta")
        set macmeta
    endif
    set noantialias
    set guifont=Monaco:h10
else
    set guifont=CodingFontTobi\ 12
endif

syntax enable
call vundle#end()
filetype plugin indent on

set t_Co=256
colorscheme betterblack

" Send to tmux
function! Get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return lines
endfunction

function! Send_select_to_last_pane()
    let non_empty_lines = filter(Get_visual_selection(), 'v:val !~ "^\\s*$"')
    let concatenated_lines = join(non_empty_lines, "")
    call system('tmux send-keys -t :.-1 -l ' . shellescape(concatenated_lines) . '')
endfunction

vnoremap <c-g> <ESC>:call Send_select_to_last_pane()<CR>
nnoremap <c-g> vaw<ESC>:call Send_select_to_last_pane()<CR>
