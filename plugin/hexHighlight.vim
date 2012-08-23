"gvim plugin for highlighting hex codes to help with tweaking colors
"Last Change: 2012 Aug 23
"Maintainer: Yuri Feldman <feldman.yuri1@gmail.com>
"License: WTFPL - Do What The Fuck You Want To Public License.
"Email me if you'd like.
let s:HexColored = 0
let s:HexColors = []

nnoremap <Leader>h :call HexHighlight()<CR>
function! HexHighlight()
    if has("gui_running")
        if s:HexColored == 0
            let hexGroup = 4
            let lineNumber = 0
            while lineNumber <= line("$")
                let currentLine = getline(lineNumber)
                let hexLineMatch = 1
                while match(currentLine, '#\x\{6}\|#\x\{3}', 0, hexLineMatch) != -1
                    let hexMatch = matchstr(currentLine, '#\x\{6}\|#\x\{3}', 0, hexLineMatch)
                    if strlen(hexMatch) == 4
                        let hexColor = join(['#',strpart(hexMatch, 1, 1),strpart(hexMatch, 1, 1),
                                    \ strpart(hexMatch, 2, 1),strpart(hexMatch, 2, 1),
                                    \ strpart(hexMatch, 3, 1),strpart(hexMatch, 3, 1)],'')
                    else
                        let hexColor = hexMatch
                    endif
                    exe 'hi hexColor'.hexGroup.' guifg='.hexColor.' guibg='.hexColor
                    exe 'let m = matchadd("hexColor'.hexGroup.'", "'.hexMatch.'", 25)'
                    let s:HexColors += ['hexColor'.hexGroup]
                    let hexGroup += 1
                    let hexLineMatch += 1
                endwhile
                let lineNumber += 1
            endwhile
            unlet lineNumber hexGroup
            let s:HexColored = 1
            echo "Highlighting hex colors..."
        elseif s:HexColored == 1
            for hexColor in s:HexColors
                exe 'highlight clear '.hexColor
            endfor
            call clearmatches()
            let s:HexColored = 0
            echo "Unhighlighting hex colors..."
        endif
    else
        echo "hexHighlight only works with a graphical version of vim"
    endif
endfunction
