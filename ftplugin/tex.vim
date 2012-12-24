if has('win32') || has ('win64')
    nnoremap <silent> <buffer> <leader>5 :w!<CR> :!start latex -output-directory=%:p:h %:p <CR>:!start yap -1 %:p:r.dvi<CR>: echo "Latex finished compiling."<CR>

    " Save file, compile .aux, then rerun latex twice (useful if you are using
    " .bib files), finally open in yap
    nnoremap  <buffer> <leader><C-%> :w<CR> :!start -output-directory=%:p:h.dvi latex %:p <CR> :!start bibtex %:p:r.aux<CR>:!start latex -output-directory=%:p:h %:p<CR> :!start latex -output-directory=%:p:h %:p<CR> :!start yap -1 %:p:r.dvi<CR>

else
    nnoremap <buffer> <leader>5 :w!<CR> :!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>:!evince %:p:r.pdf &<CR><CR>
    nnoremap <buffer> <leader>% :w!<CR> :!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>
endif

abbr simga sigma
setlocal textwidth=80
setlocal noautoindent nocindent nosmartindent indentexpr=

" turn off indenting to ampersands
setlocal indentexpr=""
