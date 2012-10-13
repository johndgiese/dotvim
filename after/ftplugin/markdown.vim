set nonumber

nnoremap <buffer> <leader>5 :!markdown % > %:p:r.html && chromium-browser %:p:r.html &<CR><CR>
