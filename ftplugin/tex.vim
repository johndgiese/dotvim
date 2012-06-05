" Save file, run latex Open file in YAP (use current window if already open)
if has('win32')
    nmap <silent> <leader>l :w<CR> :!start latex %:p<CR> :!start yap -1 %:p:r<CR>
    " Save file, compile .aux, then rerun latex twice (useful if you are using
    " .bib files), finally open in yap
    nmap  <leader>L :w<CR> :!start latex %:p<CR> :!start bibtex %:p:r.aux<CR>:!start latex %:p<CR> :!start latex %:p<CR> :!start yap -1 %:p:r.dvi<CR>
endif
set dictionary-=$VIM\vimfiles\ftplugin\latex\dictionary dictionary+=$VIM\vimfiles\ftplugin\latex\dictionary
set complete-=k complete+=k
