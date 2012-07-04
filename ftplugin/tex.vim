" Save file, move vim's cd to the directory the file is in, and run latex, open file in YAP (use current window if already open)
if has('win32') || has ('win64')
    nnoremap <silent> <F5> :w!<CR> :!start /min latex %:p -output-directory=%:p:h<CR> :!start yap -1 %:p:r<CR>: echo "Latex finished compiling."<CR>
    " Save file, compile .aux, then rerun latex twice (useful if you are using
    " .bib files), finally open in yap
    "
    " TODO: fix the full latex command
"    nnoremap  <leader>L :w<CR> :!start latex %:p -output-directory=%:p:h<CR> :!start bibtex %:p:r.aux<CR>:!start latex %:p -output-directory=%:p:h<CR> :!start latex %:p -output-directory=%:p:h<CR> :!start yap -1 %:p:r.dvi<CR>
endif
set dictionary-=$DV\ftplugin\latex\dictionary dictionary+=$DV\ftplugin\latex\dictionary
set complete-=k complete+=k
