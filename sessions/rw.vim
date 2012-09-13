" ~/.vim/sessions/rw.vim: Vim session script.
" Created by session.vim 1.5 on 08 September 2012 at 23:31:19.
" Open this file in Vim and run :source % to restore your session.

set guioptions=agit
silent! set guifont=CodingFontTobi\ 12
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'betterblack' | colorscheme betterblack | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Rudd/ruddwisdom
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +14 estimator/models.py
badd +22 vipy.py
badd +80 templates/estimator/view_estimate.html
badd +27 /usr/local/lib/python2.7/dist-packages/Django-1.4.1-py2.7.egg/django/db/models/base.py
badd +352 /usr/local/lib/python2.7/dist-packages/Django-1.4.1-py2.7.egg/django/db/models/fields/related.py
badd +92 settings.py
badd +48 templates/base.html
badd +1 estimator/views.py
args vipy.py
set lines=87 columns=266
edit estimator/views.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 1resize ' . ((&columns * 133 + 133) / 266)
exe '2resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 2resize ' . ((&columns * 133 + 133) / 266)
exe '3resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 3resize ' . ((&columns * 132 + 133) / 266)
exe '4resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 4resize ' . ((&columns * 132 + 133) / 266)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 77 - ((31 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
77
normal! 0
wincmd w
argglobal
edit templates/estimator/view_estimate.html
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 105 - ((27 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
105
normal! 011l
wincmd w
argglobal
edit estimator/views.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 49 - ((6 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
49
normal! 0
wincmd w
argglobal
enew
file vipy.py
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 1resize ' . ((&columns * 133 + 133) / 266)
exe '2resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 2resize ' . ((&columns * 133 + 133) / 266)
exe '3resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 3resize ' . ((&columns * 132 + 133) / 266)
exe '4resize ' . ((&lines * 42 + 43) / 87)
exe 'vert 4resize ' . ((&columns * 132 + 133) / 266)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
tabnext 1
2wincmd w

" vim: ft=vim ro nowrap smc=128
