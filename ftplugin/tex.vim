" <leader>5 runs latex, and then opens a pdf viewer
" <leader>% runs latex, then bibtex, then latex twice, and then opens a pdf viewer

if has('win32') || has ('win64')
    nnoremap <silent> <buffer> <leader>5 :w!<CR> :!start pdflatex -output-directory=%:p:h %:p <CR>: echo "Latex finished compiling."<CR><CR>
    nnoremap  <buffer> <leader><C-%> :w<CR> :!start -output-directory=%:p:h.dvi latex %:p <CR> :!start bibtex %:p:r.aux<CR>:!start latex -output-directory=%:p:h %:p<CR> :!start latex -output-directory=%:p:h %:p<CR> :!start yap -1 %:p:r.dvi<CR>
elseif has('mac')
    nnoremap <buffer> <leader>5 :w!<CR> :!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>:!open %:p:r.pdf &<CR><CR>
    nnoremap <buffer> <leader>% :w!<CR> :!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>:!bibtex %:p:r.aux<CR>:!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>:!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>:!open %:p:r.pdf &<CR><CR>

else
    nnoremap <buffer> <leader>5 :w!<CR> :!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>:!evince %:p:r.pdf &<CR><CR>
    nnoremap <buffer> <leader>% :w!<CR> :!pdflatex -output-directory=%:p:h -output-format=pdf %<CR>
endif

abbr simga sigma

setlocal noautoindent nocindent nosmartindent

" turn off indenting to ampersands
setlocal indentexpr=""
