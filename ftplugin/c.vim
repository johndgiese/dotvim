if has('unix')
    setlocal makeprg=make
    nnoremap <buffer> <F5> :w<CR> :make<CR>

    nnoremap <buffer> <S-F5> :!./a.out<CR>
endif
