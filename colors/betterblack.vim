set background=dark

hi Normal guibg=#060609 guifg=#e3e3e4 gui=NONE ctermbg=Black ctermfg=White cterm=NONE
" Coding 
hi String guibg=NONE guifg=#FF2020 gui=NONE ctermbg=NONE ctermfg=Red cterm=NONE
hi Comment guibg=NONE guifg=#FF7300 gui=NONE ctermbg=NONE ctermfg=Yellow cterm=NONE
hi Number guibg=NONE guifg=#C92040 gui=NONE ctermbg=NONE ctermfg=Red cterm=NONE
hi Function guibg=NONE guifg=#0Fef33 gui=NONE ctermbg=NONE ctermfg=Green cterm=NONE
hi Keyword guibg=NONE guifg=#3381FF gui=NONE ctermbg=NONE ctermfg=4 cterm=NONE
hi Statement guibg=NONE guifg=#3381FF gui=NONE ctermbg=NONE ctermfg=4 cterm=NONE
hi Identifier guibg=NONE guifg=#00ED45 gui=NONE ctermbg=NONE ctermfg=Green cterm=NONE
hi Type guibg=NONE guifg=#0052FF gui=NONE ctermbg=NONE ctermfg=4 cterm=NONE
hi Todo guibg=#151515 guifg=#FF7300 gui=NONE ctermbg=NONE ctermfg=Yellow cterm=NONE
hi Title guibg=#060609 guifg=#FFFFFF gui=NONE ctermbg=NONE ctermfg=White cterm=NONE

" VIM gui 
hi LineNr guibg=NONE guifg=#424252 gui=NONE ctermbg=White ctermfg=DarkGray cterm=NONE
hi NonText guibg=#060609 guifg=#181828 gui=NONE ctermbg=Black ctermfg=DarkGray cterm=NONE
hi PMenu guibg=#181828 guifg=#FFFFFF gui=NONE ctermbg=DarkGray ctermfg=White cterm=NONE
hi PMenuSelect guibg=#282838 guifg=#FFFFFF gui=NONE ctermbg=Black ctermfg=White cterm=NONE
hi PMenuThumb guibg=#060609 guifg=#EEFFAA gui=NONE ctermbg=Black ctermfg=Yellow cterm=NONE
hi VertSplit guibg=#060609 guifg=#181222 gui=NONE ctermbg=Black ctermfg=DarkGray cterm=NONE
hi Folded guibg=#060609 guifg=#AAFFAA gui=NONE ctermbg=Black ctermfg=White cterm=NONE
hi FoldColumn guibg=#060609 guifg=#EEFFAA gui=NONE ctermbg=Black ctermfg=Yellow cterm=NONE
hi MatchParen guibg=#555555 guifg=#FFFFFF gui=NONE ctermbg=DarkGray ctermfg=White cterm=NONE
hi TabLineFill guibg=#060609 guifg=#FFFFFF gui=NONE ctermbg=Black ctermfg=White cterm=NONE
hi TabLineSel guibg=#666666 guifg=#FFFFFF gui=NONE ctermbg=DarkGray ctermfg=White cterm=NONE
hi TabLine guibg=#222222 guifg=#FFFFFF gui=NONE ctermbg=DarkGray ctermfg=White cterm=NONE
hi Search guibg=#FFFF00 guifg=#060609 gui=NONE ctermbg=Yellow ctermfg=Black cterm=NONE
hi link IncSearch Search
hi CursorLine guibg=#252525  gui=NONE ctermbg=NONE ctermfg=Gray cterm=NONE
hi CursorColumn guibg=#252525 gui=NONE ctermbg=NONE ctermfg=Gray cterm=NONE
hi FoldColumn guibg=#060609 guifg=#FFFFFF gui=NONE ctermbg=NONE ctermfg=White cterm=NONE
hi Visual guibg=#303040 gui=NONE ctermbg=White ctermfg=DarkGray cterm=NONE
hi SignColumn guibg=#222222 guifg=#FFFFFF gui=NONE ctermbg=DarkGray ctermfg=White cterm=NONE
hi helpSpecial guibg=NONE guifg=#FFFF71

" VIM
hi link vimCommentTitle Comment

" NERDTree
hi NERDTreeDir guibg=#060609 guifg=#3372FF gui=NONE ctermbg=Black ctermfg=Blue cterm=NONE
hi NERDTreeLink guibg=#060609 guifg=#00FFFF gui=NONE ctermbg=Black ctermfg=Cyan cterm=NONE
hi NERDTreePartFile guibg=#060609 guifg=#FFFFFF gui=NONE ctermbg=Black ctermfg=White cterm=NONE
hi NERDTreeOpenable guibg=#060609 guifg=#FFFFFF gui=NONE ctermbg=Black ctermfg=White cterm=NONE
hi NERDTreePart guibg=#060609 guifg=#FFFFFF gui=NONE ctermbg=Black ctermfg=White cterm=NONE
hi NERDTreeDirSlash guibg=#060609 guifg=#0052FF gui=NONE ctermbg=Black ctermfg=White cterm=NONE
hi link NERDTreeHelp Comment

" Syntastic
hi SyntasticErrorSign guibg=#222222 guifg=#FF0000 gui=NONE ctermbg=White ctermfg=DarkGray cterm=NONE
hi SyntasticWarningSign guibg=#222222 guifg=#0000FF gui=NONE ctermbg=White ctermfg=DarkGray cterm=NONE
hi SyntasticErrorLine guibg=#2f0000
hi SpellCap guibg=NONE guifg=NONE gui=undercurl ctermbg=Black ctermfg=NONE cterm=NONE guisp=#FF1234 

" Taglist
hi TaglistFileName guibg=#060609 guifg=#FFFFFF gui=italic ctermbg=Black ctermfg=White cterm=NONE
hi TaglistTagName guibg=#060609 guifg=#00ED45 gui=NONE ctermbg=Black ctermfg=Green cterm=NONE
hi TaglistTitle guibg=#060609 guifg=#FF0000 gui=NONE ctermbg=Black ctermfg=Red cterm=NONE
hi link TagListComment Comment

" TagBar
hi TagbarHighlight guibg=#333333 guifg=NONE gui=NONE  ctermbg=DarkGray ctermfg=NONE cterm=NONE

" Python
hi link PythonEscape String
hi link PythonDecorator PythonFunction
hi link pythonDocTestValue Normal

" MATLAB
hi link matlabSemicolon Normal
hi link matlabImplicit Normal
hi link matlabOperator Normal

" Markdown
hi link markdownItalic Normal
hi markdownH1 guibg=#060609 guifg=#44FF44 gui=NONE ctermbg=Black ctermfg=Green cterm=NONE
hi markdownH2 guibg=#060609 guifg=#77FFBB gui=NONE ctermbg=Black ctermfg=Green cterm=NONE
hi markdownH3 guibg=#060609 guifg=#AAFFBB gui=NONE ctermbg=Black ctermfg=Green cterm=NONE
hi markdownHeadingDelimiter NONE

" HTML
hi link htmlLink Normal

" Javascript
hi link Javascript Normal
hi JavascriptRegexpString guibg=NONE guifg=#21C6EB gui=NONE ctermbg=NONE ctermfg=Blue cterm=NONE
hi link JavascriptSpecial JavascriptRegexpString
hi JavascriptRegexpCharClass guibg=NONE guifg=#98E4F5 gui=NONE ctermbg=NONE ctermfg=Blue cterm=NONE

" Vimdiff
hi DiffAdd guibg=#22FF22 guifg=#060609 gui=None ctermbg=DarkGreen ctermfg=Black cterm=NONE
hi DiffDelete guibg=#FF2222 guifg=#060609 gui=None ctermbg=DarkRed ctermfg=Black cterm=NONE
hi DiffChange guibg=#4444FF guifg=#060609 gui=None ctermbg=DarkBlue ctermfg=Black cterm=NONE
hi DiffText guibg=#8888FF guifg=#060609 gui=None ctermbg=Blue ctermfg=Black cterm=NONE

" PHP
hi link phpRegion Normal
hi link Delimiter Normal
hi link None String
hi link phpStringSingle String
hi link phpStringDouble String
hi link phpVarSelector Normal
hi link phpIdentifier Normal
hi link phpOperator Normal
hi link phpRelation Normal
