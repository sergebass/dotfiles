""" ----------------------------------
""" Haskell-specific vim configuration
""" ----------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

setlocal keywordprg=stack\ hoogle\ --\ --count=100
setlocal makeprg=stack\ build

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
nnoremap <buffer> <F1> :!xdg-open "https://haskell.org/hoogle/"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://www.stackage.org"<CR>

" search the word under cursor in Hoogle database (using browser)
nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

nnoremap <buffer> \\sc :!stack clean<CR>
nnoremap <buffer> \\sb :!stack build<CR>
nnoremap <buffer> \\st :!stack test<CR>
nnoremap <buffer> \\si :!stack install<CR>
nnoremap <buffer> \\sr :term stack repl<CR>

" SPC m g g 	go to definition or tag
" SPC m g i 	cycle the Haskell import lines or return to point (with prefix arg)
" SPC m F 	format buffer using haskell-stylish
" SPC m f 	format declaration using hindent (if enabled)

" 3.1 Documentation
" Documentation commands are prefixed by SPC m h
" SPC m h d 	find or generate Haddock documentation for the identifier under the cursor
" SPC m h f 	do a helm-hoogle lookup
" SPC m h h 	do a Hoogle lookup
" SPC m h H 	do a local Hoogle lookup
" SPC m h i 	gets information for the identifier under the cursor
" SPC m h t 	gets the type of the identifier under the cursor
" SPC m h y 	do a Hayoo lookup

" 3.2 Debug
" Debug commands are prefixed by SPC m d:
" SPC m d a 	abandon current process
" SPC m d b 	insert breakpoint at function
" SPC m d B 	delete breakpoint
" SPC m d c 	continue current process
" SPC m d d 	start debug process, needs to be run first
" SPC m d n 	next breakpoint
" SPC m d N 	previous breakpoint
" SPC m d p 	previous breakpoint
" SPC m d r 	refresh process buffer
" SPC m d s 	step into the next function
" SPC m d t 	trace the expression

" 3.3 Debug Buffer
" RET 	select object at the point
" a 	abandon current computation
" b 	break on function
" c 	continue the current computation
" d 	delete object at the point
" n 	go to next step to inspect bindings
" N or p 	go to previous step to inspect the bindings
" r 	refresh the debugger buffer
" s 	step into the next function
" t 	trace the expression

" 3.4 REPL
" REPL commands are prefixed by SPC m s:
" SPC m s b 	load or reload the current buffer into the REPL
" SPC m s c 	clear the REPL
" SPC m s s 	show the REPL without switching to it
" SPC m s S 	show and switch to the REPL

" 3.5 Intero REPL
" Intero REPL commands are prefixed by SPC m i:
" SPC m i c 	change directory in the backend process
" SPC m i d 	reload the module DevelMain and then run DevelMain.update
" SPC m i k 	stop the current worker process and kill its associated
" SPC m i l 	list hidden process buffers created by intero
" SPC m i r 	restart the process with the same configuration as before
" SPC m i t 	set the targets to use for stack ghci

" 3.6 Cabal commands
" Cabal commands are prefixed by SPC m c:
" SPC m c a 	cabal actions
" SPC m c b 	build the current cabal project, i.e. invoke cabal build
" SPC m c c 	compile the current project, i.e. invoke ghc
" SPC m c v 	visit the cabal file

" 3.7 Cabal files
" This commands are available in a cabal file.
" SPC m d 	add a dependency to the project
" SPC m b 	go to benchmark section
" SPC m e 	go to executable section
" SPC m t 	go to test-suite section
" SPC m m 	go to exposed modules
" SPC m l 	go to libary section
" SPC m n 	go to next subsection
" SPC m p 	go to previous subsection
" SPC m s c 	clear the REPL
" SPC m s s 	show the REPL without switching to it
" SPC m s S 	show and switch to the REPL
" SPC m N 	go to next section
" SPC m P 	go to previous section
" SPC m f 	find or create source-file under the cursor

" 3.8 Refactor
" Refactor commands are prefixed by SPC m r:
" SPC m r b 	apply all HLint suggestions in the current buffer
" SPC m r r 	apply the HLint suggestion under the cursor
" SPC m r s 	list all Intero suggestions

" Only some of the HLint suggestions can be applied.

" To apply the intero suggestions, press `C-c C-c` when the window is open, which is also shown in the window that appears.

" 3.9 Ghc-mod

" These commands are only available when ghc-mod is enabled.
" For more info, see http://www.mew.org/~kazu/proj/ghc-mod/en/emacs.html

" ghc-mod commands are prefixed by SPC m m:
" SPC t 	insert template
" SPC m m u 	insert template with holes
" SPC m m a 	select one of possible cases (ghc-auto)
" SPC m m f 	replace a hole (ghc-refine)
" SPC m m e 	expand template haskell
" SPC m m n 	go to next type hole
" SPC m m p 	go to previous type hole
" SPC m m > 	make indent deeper
" SPC m m < 	make indent shallower

" -----------------------------------------------------------------------------
" Apply workspace-specific Haskell settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-haskell.vim"))
    source ~/.workspace-haskell.vim
endif
