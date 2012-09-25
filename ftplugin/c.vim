if has('unix')
    setlocal makeprg=make
    nnoremap <buffer> <leader>5 :w<CR> :make<CR>

    nnoremap <buffer> <leader>% :!./a.out<CR>
endif
