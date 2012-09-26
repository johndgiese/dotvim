nnoremap <buffer> <leader>% :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

if has('unix')
    nnoremap <buffer> <leader>5 :!chromium-browser % &<CR><CR>
endif

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
