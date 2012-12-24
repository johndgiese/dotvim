set nonumber

nnoremap <buffer> <leader>5 :!markdown % > %:p:r.html && chromium-browser %:p:r.html &<CR><CR>

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set textwidth=80

let g:snipMate = {}
let g:snipMate.scope_aliases = {} 
let g:snipMate.scope_aliases['markdown'] = 'markdown,tex'
