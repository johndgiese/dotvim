" Get Win32 Short Name
" Author: Michael Geddes <michaelrgeddes@optushome.com.au>
" Version: 1.0

" Get the short-form-name of a filename (the whole directory path)
fun! GetWin32ShortName( filename )
	let fn=a:filename
	if !isdirectory(fn) && ! filereadable(fn)
		return fn
	endif

	let base=fnamemodify(fn,':h')
	let file=fnamemodify(fn,':t')
	if base==fn
		return base
	endif
	let base=GetWin32ShortName( base )
	if base !~ '[/\\]$'
		let base=base.'\'
	endif
	if isdirectory(base)
		if file=~' ' || file =~ '\..*\.' || file =~ '\.[^.]\{4,}$' || file=~'^[^.]\{9}'

			let short=substitute(file,' ', '', 'g')
			let ext=matchstr(short,'\.[^\.]\{3}\([^\.]*$\)\@=')
			let short=substitute(short,'\..*$','','')
			
			let orig=expand(base.file,':p')
			if orig != ''
				let c=1
				while c<20
					let file=strpart(short,0,(7-strlen(c))).'~'.c.ext
					if expand( base.file,':p' ) == orig
						break
					endif
					let c=c+1
				endwhile
			endif
		endif
	endif

	return base.file
endfun

