""" -----------------------------------
""" Markdown-specific vim configuration
""" -----------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
nnoremap <buffer> <F1> :!xdg-open "https://markdown-guide.readthedocs.io/en/latest/basics.html"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://daringfireball.net/projects/markdown/syntax"<CR>

" 5.1 Element insertion
" SPC m - 	insert horizontal line
" SPC m h i 	insert header dwim
" SPC m h I 	insert header setext dwim
" SPC m h 1 	insert header atx 1
" SPC m h 2 	insert header atx 2
" SPC m h 3 	insert header atx 3
" SPC m h 4 	insert header atx 4
" SPC m h 5 	insert header atx 5
" SPC m h 6 	insert header atx 6
" SPC m h ! 	insert header setext 1
" SPC m h @ 	insert header setext 2
" SPC m i l 	insert link
" SPC m i L 	insert reference link dwim
" SPC m i u 	insert uri
" SPC m i f 	insert footnote
" SPC m i w 	insert wiki link
" SPC m i i 	insert image
" SPC m i I 	insert reference image
" SPC m x b 	make region bold or insert bold
" SPC m x i 	make region italic or insert italic
" SPC m x c 	make region code or insert code
" SPC m x C 	make region code or insert code (Github Flavored Markdown format)
" SPC m x q 	make region blockquote or insert blockquote
" SPC m x Q 	blockquote region
" SPC m x p 	make region or insert pre
" SPC m x P 	pre region

" 5.2 Element removal
" SPC m k 	kill thing at point

" 5.3 Completion
" SPC m ] 	complete

" 5.4 Following and Jumping
" SPC m o 	follow thing at point
" SPC m j 	jump

" 5.5 Indentation
" SPC m \> 	indent region
" SPC m \< 	exdent region

" 5.6 Header navigation
" gj 	outline forward same level
" gk 	outline backward same level
" gh 	outline up one level
" gl 	outline next visible heading

" 5.7 Buffer-wide commands
" SPC m c ] 	complete buffer
" SPC m c m 	other window
" SPC m c p 	preview
" SPC m c P 	live preview using engine defined with layer variable markdown-live-preview-engine
" SPC m c e 	export
" SPC m c v 	export and preview
" SPC m c o 	open
" SPC m c w 	kill ring save
" SPC m c c 	check refs
" SPC m c n 	cleanup list numbers
" SPC m c r 	render buffer

" 5.8 List editing
" SPC m l i 	insert list item

" 5.9 Movement
" SPC m { 	backward paragraph
" SPC m } 	forward paragraph
" SPC m N 	next link
" SPC m P 	previous link

" 5.10 Promotion, Demotion
" M-k 	markdown-move-up
" M-j 	markdown-move-down
" M-h 	markdown-promote
" M-l 	markdown-demote

" -----------------------------------------------------------------------------
" Apply workspace-specific Markdown settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-markdown.vim"))
    source ~/.workspace-markdown.vim
endif
