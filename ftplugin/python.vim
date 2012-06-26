let g:ipy_perform_mappings=0
noremap <silent> <F5> :w<CR>:python run_this_file()<CR>
noremap <silent> K :py get_doc_buffer()<CR>
noremap <silent> <F9> :python run_these_lines()<CR>
noremap <silent> <F12> :cd %:p:h<CR> :!start /min ipython qtconsole<CR>:sleep 2<CR>:IPython<CR>:py if update_subchannel_msgs(force=True): echo("vim-ipython shell updated",'Operator')<CR><C-w><S-H><C-w><c-w>:setlocal nonumber<CR>:15 new commandwindow.py<CR><c-w>r:setlocal nonumber<CR>
noremap <silent> <S-F12> :b vim-ipython<CR>ggdG<CR>:2bp<CR>
inoremap <silent> <S-CR> <ESC>:set nohlsearch<CR>V?^\n<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>Go<ESC>o
nnoremap <silent> <S-CR> :set nohlsearch<CR>/^\n<CR>V?^\n<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>j
nnoremap <silent> <C-CR> :set nohlsearch<CR>/^##\\|\%$<CR>:let @/ = ""<CR>kV?^##\\|\%^<CR>:python run_these_lines()<CR>:let @/ = ""<CR>:set hlsearch<CR>
" same as above, except moves to the next cell
nnoremap <silent> <C-S-CR> :set nohlsearch<CR>/^##\\|\%$<CR>:let @/ = ""<CR>kV?^##\\|\%^<CR>:python run_these_lines()<CR>N:let @/ = ""<CR>:set hlsearch<CR>
