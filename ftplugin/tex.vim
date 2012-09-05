if has('win32') || has ('win64')
    nnoremap <silent> <buffer> <F5> :w!<CR> :!start latex -output-directory=%:p:h %:p <CR>:!start yap -1 %:p:r.dvi<CR>: echo "Latex finished compiling."<CR>

    " Save file, compile .aux, then rerun latex twice (useful if you are using
    " .bib files), finally open in yap
    nnoremap  <buffer> <C-S-F5> :w<CR> :!start -output-directory=%:p:h.dvi latex %:p <CR> :!start bibtex %:p:r.aux<CR>:!start latex -output-directory=%:p:h %:p<CR> :!start latex -output-directory=%:p:h %:p<CR> :!start yap -1 %:p:r.dvi<CR>

else
    nnoremap <silent> <buffer> <F5> :w!<CR> :silent !latex -output-directory=%:p:h % &<CR>:silent !evince %:p:r.dvi &<CR><CR>
    nnoremap <silent> <buffer> <S-F5> :w!<CR> :!latex -output-directory=%:p:h %<CR>
endif

abbr simga sigma
