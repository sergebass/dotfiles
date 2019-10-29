""" -------------------------------
""" C++-SPECIFIC CONFIGURATION
""" -------------------------------

" I don't like tabs, use spaces throughout
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" for some reason vim-commentary uses /* */ C-style commenting, but let's use // instead
setlocal commentstring=//\ %s

" setlocal keywordprg=man

" FIXME should this be in global configuration instead?
" This is a new feature in vim to better integrate with gdb
packadd termdebug

" FIXME should this be in global configuration instead?
" FIXME configure this:
" let g:termdebug_wide = 163

" TODO add shortcuts for :Break, :Clear, :Evaluate etc.
" :Termdebug
" :Gdb " jump to the gdb window
" :Program "jump to the window with the running program
" :Source "jump to the window with the source code, create it if there isn't one
"
" :Break " set a breakpoint at the current line; a sign will be displayed
nnoremap <buffer> <F9> :Break<CR>
" :Clear " delete the breakpoint at the current line
nnoremap <buffer> <F10> :Clear<CR>
"
" :Run [args]      run the program with [args] or the previous arguments
" :Arguments {args}  set arguments for the next `:Run`
" :Stop    interrupt the program
"
" :Step    execute the gdb "step" command
nnoremap <buffer> <F5> :Step<CR>
" :Over    execute the gdb "next" command (`:Next` is a Vim command)
nnoremap <buffer> <F6> :Over<CR>
" :Finish  execute the gdb "finish" command
nnoremap <buffer> <F7> :Finish<CR>
" :Continue    execute the gdb "continue" command
nnoremap <buffer> <F8> :Continue<CR>
"
" :Evaluate (or just plain K)
" :'<,'>Evaluate` "evaluate the Visually selected text
nnoremap <buffer> <F3> :Evaluate<CR>
vnoremap <buffer> <F3> :Evaluate<CR>
nnoremap <RightMouse> :Evaluate<CR>

" nnoremap <buffer> K :call LanguageClient#textDocument_hover()<CR>
nmap <buffer> <CR>hh :call LanguageClient#textDocument_hover()<CR>

nnoremap <buffer> <F1> :!xdg-open "https://en.cppreference.com/w/cpp"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "http://www.cplusplus.com"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> \\?1 :!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?1 "*y<Esc>:!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> \\?2 :!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?2 "*y<Esc>:!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" toggle between source and header
" (TODO)
" SPC m g a 	open matching file (e.g. switch between .cpp and .h)
" SPC m g A 	open matching file in another window (e.g. switch between .cpp and .h)
" FIXME this doesn't work!
nmap <buffer> <CR>ga :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>

" nnoremap <buffer> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> <CR><CR> :call LanguageClient#textDocument_definition()<CR>
nmap <buffer> <CR>gg <CR><CR>

nnoremap <buffer> <CR>rr :call LanguageClient#textDocument_rename()<CR>

" SPC m D 	disaster: disassemble c/c++ code

" LanguageClient#textDocument_typeDefinition()
" LanguageClient#textDocument_implementation()
" LanguageClient#textDocument_documentSymbol()
" LanguageClient#textDocument_references()
" LanguageClient#textDocument_codeAction()
" LanguageClient#textDocument_completion()
" LanguageClient#textDocument_formatting()
" LanguageClient#textDocument_rangeFormatting()
" LanguageClient#textDocument_documentHighlight()
" LanguageClient#clearDocumentHighlight()
" LanguageClient#workspace_symbol()
" LanguageClient#workspace_applyEdit()
" LanguageClient#workspace_()
" LanguageClient#workspace_()
