set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "David"

hi Normal guibg=black guifg=white gui=NONE
" Coding 
hi string guibg=NONE guifg=#FF0000 gui=NONE
hi comment guibg=NONE guifg=#FF7300 gui=NONE
hi number guibg=NONE guifg=#C90000 gui=NONE
hi function guibg=NONE guifg=#0Fef33 gui=NONE
hi keyword guibg=NONE guifg=#0051FF gui=NONE
hi statement guibg=NONE guifg=#0052FF gui=NONE
hi Type guibg=NONE guifg=#0052FF gui=NONE
hi Todo guibg=#151515 guifg=#FF7300 gui=bold
hi Title guibg=black guifg=#FFFF44 gui=bold

" VIM gui 
hi LineNr guibg=#111111 guifg=white gui=NONE
hi NonText guibg=black guifg=#333333 gui=NONE
hi PMenu guibg=#252525 guifg=white gui=NONE
hi PMenuSelect guibg=#151515 guifg=white gui=NONE
hi VertSplit guibg=black guifg=#333333 gui=bold
hi Folded guibg=black guifg=#AAFFAA gui=bold
hi FoldColumn guibg=black guifg=#EEFFAA gui=bold
hi PMenuThumb guibg=black guifg=#EEFFAA gui=NONE
hi MatchParen guibg=#555555 guifg=white gui=NONE
hi TabLineFill guibg=black guifg=white gui=NONE
hi TabLineSel guibg=#666666 guifg=white gui=NONE
hi TabLine guibg=#333333 guifg=white gui=NONE
hi StatusLine guibg=#333333 guifg=white gui=NONE
hi StatusLineNC guibg=#333333 guifg=white gui=NONE
hi IncSearch guibg=#333333 guifg=white gui=NONE
hi CursorLine guibg=#252525  gui=NONE
hi CursorColumn guibg=#252525 gui=NONE

" NERDTree
hi NERDTreeDir guibg=black guifg=#0052FF gui=NONE
hi NERDTreeLink guibg=black guifg=cyan gui=NONE
hi NERDTreePartFile guibg=black guifg=white gui=NONE
hi NERDTreeOpenable guibg=black guifg=white gui=NONE
hi NERDTreePart guibg=black guifg=white gui=NONE
hi NERDTreeDirSlash guibg=black guifg=#0052FF gui=NONE
" CTags 
hi TagListFileName guibg=#151515 guifg=white gui=bold,italic 
