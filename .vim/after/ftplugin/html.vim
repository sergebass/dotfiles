""" -------------------------------
""" HTML-specific vim configuration
""" -------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" TODO find relevant utilities to do formatting and quick lookup:
"setlocal equalprg=html-tidy
"setlocal keywordprg=hoogle

" setlocal omnifunc=htmlcomplete#DetectOmniFlavor

nnoremap <buffer> <F1> :!sp-open "https://www.w3schools.com/tags/default.asp"<CR>
nnoremap <buffer> <M-F1> :!sp-open "https://dev.w3.org/html5/html-author/"<CR>

nnoremap <buffer> \\g :BrowserOpen<CR>
nnoremap <buffer> \\v :Validate<CR>

" TODO add a mapping for xmllint --html (?)
"noremap <buffer> \\= <Esc>:XmlFormat<CR>

" 3.1 Web mode
" SPC m g p 	quickly navigate CSS rules using helm
" SPC m e h 	highlight DOM errors
" SPC m g b 	go to the beginning of current element
" SPC m g c 	go to the first child element
" SPC m g p 	go to the parent element
" SPC m g s 	go to next sibling
" SPC m h p 	show xpath of the current element
" SPC m r c 	clone the current element
" SPC m r d 	delete the current element (does not delete the children)
" SPC m r r 	rename current element
" SPC m r w 	wrap current element
" SPC m z 	fold/unfold current element
" % 	evil-matchit keybinding to jump to closing tag

" A transient-state is also defined, start it with SPC m . or ~, .~

" ? 	Toggle full help
" c 	clone current element
" d 	delete (vanish) current element (does not delete the children)
" D 	delete current element and children
" j 	next element
" J / gj 	next sibling element
" h 	parent element
" k 	previous element
" K / gk 	previous sibling element
" l 	first child element
" p 	show xpath of current element
" q 	leave the transient-state
" r 	rename current element
" w 	wrap current element

" 3.2 CSS/SCSS
" SPC m g h 	quickly navigate CSS rules using helm
" SPC m z c 	fold css statement to one line
" SPC m z o 	unfold css statement to one line

" -----------------------------------------------------------------------------
" Apply workspace-specific HTML settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-html.vim"))
    source ~/.workspace-html.vim
endif
