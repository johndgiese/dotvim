nnoremap <buffer> <leader>% :silent 1,$!xmllint --format --recover - 2>/dev/null<CR>

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal equalprg=tidy\ -quiet\ -indent\ --indent-spaces\ 2\ --doctype\ omit\ --wrap\ 120\ -xml
setlocal makeprg=tidy\ -quiet\ -e\ %
