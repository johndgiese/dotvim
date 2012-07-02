set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "betterblack"

hi Normal guibg=#000000 guifg=#FFFFFF gui=NONE
" Coding 
hi String guibg=NONE guifg=#FF0000 gui=NONE
hi Comment guibg=NONE guifg=#FF7300 gui=NONE
hi Number guibg=NONE guifg=#C92040 gui=bold
hi Function guibg=NONE guifg=#0Fef33 gui=NONE
hi Keyword guibg=NONE guifg=#0051FF gui=NONE
hi Statement guibg=NONE guifg=#0052FF gui=NONE
hi Identifier guibg=NONE guifg=#00ED45 gui=NONE
hi Type guibg=NONE guifg=#0052FF gui=NONE
hi Todo guibg=#151515 guifg=#FF7300 gui=bold
hi Title guibg=#000000 guifg=#FFFFFF gui=bold

" VIM gui 
hi LineNr guibg=#222222 guifg=#FFFFFF gui=NONE
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
hi TabLine guibg=#222222 guifg=#FFFFFF gui=NONE
hi StatusLine guibg=#222222 guifg=#FFFFFF gui=NONE
hi StatusLineNC guibg=#222222 guifg=#FFFFFF gui=NONE
hi Search guibg=#FFFF22 guifg=#000000 gui=NONE
hi IncSearch guibg=#CCCCFF guifg=#000000 gui=NONE
hi CursorLine guibg=#252525  gui=NONE
hi CursorColumn guibg=#252525 gui=NONE
hi FoldColumn guibg=#000000 guifg=#FFFFFF gui=NONE
hi Visual guibg=#222222 gui=NONE

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

" TagBar
hi TagbarHighlight guibg=#333333 guifg=NONE gui=bold 

" Python
hi link PythonEscape String

" MATLAB
hi link matlabSemicolon Normal
hi link matlabImplicit Normal
hi link matlabOperator Normal

" Javascript
hi link Javascript Normal
hi link JavascriptSpecial String

" PHP
hi link phpRegion Normal
hi link Delimiter Normal
hi link None String
hi link phpStringSingle String
hi link phpStringDouble String
hi phpVarSelector guibg=NONE guifg=#00EF50 gui=NONE
hi phpIdentifier guibg=NONE guifg=#00EF50 gui=NONE
