""" -------------------------------------
""" Javascript-specific vim configuration
""" -------------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
setlocal makeprg=eslint\ -f\ unix

" Override default :RgId to use correct file type for JavaScript files (the one that rg expects)
command! -bang -nargs=* RgId
  \ call fzf#vim#grep(
  \   'rg -t js --column --line-number --no-heading --color=always --word-regexp --case-sensitive '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Override default :AgId to use correct file type for JavaScript files (the one that ag expects)
command! -bang -nargs=* AgId
  \ call fzf#vim#grep(
  \   'ag --js --nogroup --column --color --word-regexp --case-sensitive '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
nnoremap <buffer> <F1> :!xdg-open "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://dev.w3.org/html5/html-author/"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

" 4.1 js2-mode
" Key Binding 	Description
" SPC m w 	toggle js2-mode warnings and errors
" % 	jump between blockswith evil-matchit

" 4.2 Folding (js2-mode)
" Key Binding 	Description
" SPC m z c 	hide element
" SPC m z o 	show element
" SPC m z r 	show all element
" SPC m z e 	toggle hide/show element
" SPC m z F 	toggle hide functions
" SPC m z C 	toggle hide comments

" 4.3 Refactoring (js2-refactor)
" Bindings should match the plain emacs assignments.
" Key Binding 	Description
" SPC m k 	deletes to the end of the line, but does not cross semantic boundaries
" SPC m r 3 i 	converts ternary operator to if-statement
" SPC m r a g 	creates a /* global */ annotation if it is missing, and adds var to point to it
" SPC m r a o 	replaces arguments to a function call with an object literal of named arguments
" SPC m r b a 	moves the last child out of current function, if-statement, for-loop or while-loop
" SPC m r c a 	converts a multiline array to one line
" SPC m r c o 	converts a multiline object literal to one line
" SPC m r c u 	converts a multiline function to one line (expecting semicolons as statement delimiters)
" SPC m r e a 	converts a one line array to multiline
" SPC m r e f 	extracts the marked expressions into a new named function
" SPC m r e m 	extracts the marked expressions out into a new method in an object literal
" SPC m r e o 	converts a one line object literal to multiline
" SPC m r e u 	converts a one line function to multiline (expecting semicolons as statement delimiters)
" SPC m r e v 	takes a marked expression and replaces it with a var
" SPC m r i g 	creates a shortcut for a marked global by injecting it in the wrapping immediately invoked function expression
" SPC m r i p 	changes the marked expression to a parameter in a local function
" SPC m r i v 	replaces all instances of a variable with its initial value
" SPC m r l p 	changes a parameter to a local var in a local function
" SPC m r l t 	adds a console.log statement for what is at point (or region)
" SPC m r r v 	renames the variable on point and all occurrences in its lexical scope
" SPC m r s l 	moves the next statement into current function, if-statement, for-loop, while-loop
" SPC m r s s 	splits a String
" SPC m r s v 	splits a var with multiple vars declared into several var statements
" SPC m r t f 	toggle between function declaration and function expression
" SPC m r u w 	replaces the parent statement with the selected region
" SPC m r v t 	changes local var a to be this.a instead
" SPC m r w i 	wraps the entire buffer in an immediately invoked function expression
" SPC m r w l 	wraps the region in a for-loop
" SPC m x m j 	move line down, while keeping commas correctly placed
" SPC m x m k 	move line up, while keeping commas correctly placed

" 4.4 Formatting (web-beautify)
" Key Binding 	Description
" SPC m = 	beautify code in js2-mode, json-mode, web-mode, and css-mode

" 4.4.1 Documentation (js-doc)

" You can check more here
" Key Binding 	Description
" SPC m r d b 	insert JSDoc comment for current file
" SPC m r d f 	insert JSDoc comment for function
" SPC m r d t 	insert tag to comment
" SPC m r d h 	show list of available jsdoc tags

" 4.5 Auto-complete and documentation (tern)
" Key Binding 	Description
" SPC m C-g 	brings you back to last place you were when you pressed M-..
" SPC m g g 	jump to the definition of the thing under the cursor
" SPC m g G 	jump to definition for the given name
" SPC m h d 	find docs of the thing under the cursor. Press again to open the associated URL (if any)
" SPC m h t 	find the type of the thing under the cursor
" SPC m r r V 	rename variable under the cursor using tern

" 4.6 JSON
" Key Binding 	Description
" SPC m h p 	Get the path of the value at point

" 4.7 REPL (skewer-mode)
" Key Binding 	Description
" SPC m e e 	evaluates the last expression
" SPC m e E 	evaluates and inserts the result of the last expression at point
" Key Binding 	Description
" SPC m s a 	Toggle live evaluation of whole buffer in REPL on buffer changes
" SPC m s b 	send current buffer contents to the skewer REPL
" SPC m s B 	send current buffer contents to the skewer REPL and switch to it in insert state
" SPC m s f 	send current function at point to the skewer REPL
" SPC m s F 	send current function at point to the skewer REPL and switch to it in insert state
" SPC m s i 	starts/switch to the skewer REPL
" SPC m s r 	send current region to the skewer REPL
" SPC m s R 	send current region to the skewer REPL and switch to it in insert state
" SPC m s s 	switch to REPL

" -----------------------------------------------------------------------------
" Apply workspace-specific Javascript settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-javascript.vim"))
    source ~/.workspace-javascript.vim
endif
