set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "betterblack"

hi Normal guibg=#000000 guifg=#FFFFFF gui=NONE
" Coding 
hi string guibg=NONE guifg=#FF0000 gui=NONE
hi comment guibg=NONE guifg=#FF7300 gui=NONE
hi number guibg=NONE guifg=#C92040 gui=bold
hi function guibg=NONE guifg=#0Fef33 gui=NONE
hi keyword guibg=NONE guifg=#0051FF gui=NONE
hi statement guibg=NONE guifg=#0052FF gui=NONE
hi Type guibg=NONE guifg=#0052FF gui=NONE
hi Todo guibg=#151515 guifg=#FF7300 gui=bold
hi Title guibg=#000000 guifg=#FFFFFF gui=bold

" VIM gui 
hi LineNr guibg=#111111 guifg=#FFFFFF gui=NONE
hi NonText guibg=#000000 guifg=#333333 gui=NONE
hi PMenu guibg=#252525 guifg=#FFFFFF gui=NONE
hi PMenuSelect guibg=#151515 guifg=#FFFFFF gui=NONE
hi VertSplit guibg=#000000 guifg=#333333 gui=bold
hi Folded guibg=#000000 guifg=#AAFFAA gui=bold
hi FoldColumn guibg=#000000 guifg=#EEFFAA gui=bold
hi PMenuThumb guibg=#000000 guifg=#EEFFAA gui=NONE
hi MatchParen guibg=#555555 guifg=#FFFFFF gui=NONE
hi TabLineFill guibg=#000000 guifg=#FFFFFF gui=NONE
hi TabLineSel guibg=#666666 guifg=#FFFFFF gui=NONE
hi TabLine guibg=#333333 guifg=#FFFFFF gui=NONE
hi StatusLine guibg=#333333 guifg=#FFFFFF gui=NONE
hi StatusLineNC guibg=#333333 guifg=#FFFFFF gui=NONE
hi IncSearch guibg=#FFFF44 guifg=#FFFFFF gui=NONE
hi CursorLine guibg=#252525  gui=NONE
hi CursorColumn guibg=#252525 gui=NONE
hi FoldColumn guibg=#000000 guifg=#FFFFFF gui=NONE
hi Visual guibg=#333333 gui=NONE

" NERDTree
hi NERDTreeDir guibg=#000000 guifg=#0052FF gui=NONE
hi NERDTreeLink guibg=#000000 guifg=#00FFFF gui=NONE
hi NERDTreePartFile guibg=#000000 guifg=#FFFFFF gui=NONE
hi NERDTreeOpenable guibg=#000000 guifg=#FFFFFF gui=NONE
hi NERDTreePart guibg=#000000 guifg=#FFFFFF gui=NONE
hi NERDTreeDirSlash guibg=#000000 guifg=#0052FF gui=NONE
hi link NERDTreeHelp Comment

" Taglist
hi TaglistFileName guibg=#000000 guifg=#FFFFFF gui=italic
hi TaglistTagName guibg=#000000 guifg=#00ED45 gui=NONE
hi TaglistTitle guibg=#000000 guifg=#FF0000 gui=NONE
hi link TagListComment Comment

" MATLAB
hi link matlabSemicolon Normal
hi link matlabImplicit Normal
hi link matlabOperator Normal

" Javascript
hi link Javascript Normal
