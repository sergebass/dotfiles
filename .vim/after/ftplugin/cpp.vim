""" -------------------------------
""" C++-SPECIFIC CONFIGURATION
""" -------------------------------

" I don't like tabs, use spaces throughout
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" Only use valid C++ identifier characters
setlocal iskeyword=@,48-57,_

" for some reason vim-commentary uses /* */ C-style commenting, but let's use // instead
setlocal commentstring=//\ %s

" setlocal keywordprg=man

" do our formatting using clang-format and the '=' command
setlocal equalprg=clang-format

" FIXME should this be in global configuration instead?
" This is a new feature in vim to better integrate with gdb
packadd termdebug

" Use gdb as our debugger
let termdebugger = "gdb"

" FIXME should this be in global configuration instead?
" FIXME configure this:
" let g:termdebug_wide = 163

" start debugging session
nnoremap <buffer> \<F9> :Termdebug<CR>
" :Run [args]      run the program with [args] or the previous arguments
nnoremap <buffer> \<F5> :Run<CR>
" :Arguments {args}  set arguments for the next `:Run`
" :Stop    interrupt the program
nnoremap <buffer> \<F10> :Stop<CR>

" (the shortcuts for quick navigation between debugger, program output and source during debugging
" are defined in the main mapping file)

" :Break " set a breakpoint at the current line; a sign will be displayed
nnoremap <buffer> <F9> :Break<CR>
" :Clear " delete the breakpoint at the current line
nnoremap <buffer> <F10> :Clear<CR>

" :Step    execute the gdb "step" command
nnoremap <buffer> <F5> :Step<CR>
tnoremap <F5> step<CR>
" :Over    execute the gdb "next" command (`:Next` is a Vim command)
nnoremap <buffer> <F6> :Over<CR>
tnoremap <F6> next<CR>
" :Finish  execute the gdb "finish" command
nnoremap <buffer> <F7> :Finish<CR>
tnoremap <F7> finish<CR>
" :Continue    execute the gdb "continue" command
nnoremap <buffer> <F8> :Continue<CR>
tnoremap <F8> continue<CR>

" :Evaluate (or just plain K)
" :'<,'>Evaluate` "evaluate the Visually selected text
nnoremap <buffer> <F1> :Evaluate<CR>
vnoremap <buffer> <F1> :Evaluate<CR>
nnoremap <buffer> <RightMouse> :Evaluate<CR>
tnoremap <F1> print<Space>

nnoremap <buffer> <F12> :Evaluate<Space>
nnoremap <buffer> \<F1> :Evaluate<Space>
tnoremap \<F1> print<Space>

nnoremap <buffer> \\dt :call TermDebugSendCommand('info threads')<CR>
nnoremap <buffer> \\dl :call TermDebugSendCommand('info locals')<CR>
nnoremap <buffer> \\db :call TermDebugSendCommand('info breakpoints')<CR>
nnoremap <buffer> \\dr :call TermDebugSendCommand('info registers')<CR>
nnoremap <buffer> \\df :call TermDebugSendCommand('frame')<CR>
nnoremap <buffer> \\ds :call TermDebugSendCommand('backtrace')<CR>


" Debugging keybindings from develop.spacemacs.org
" ------------------------------------------------
" SPC m d d d   start debugging
nnoremap <buffer> <CR>ddd :Termdebug<CR>
" SPC m d d l   debug last configuration
" SPC m d d r   debug recent configuration
" SPC m d c     continue
nnoremap <buffer> <CR>dc :Continue<CR>
" SPC m d i     step in
nnoremap <buffer> <CR>di :Step<CR>
" SPC m d o     step out
nnoremap <buffer> <CR>do :Finish<CR>
" SPC m d s     next step
nnoremap <buffer> <CR>ds :Over<CR>
" SPC m d v     inspect value at point
nnoremap <buffer> <CR>dv :Evaluate<CR>
" SPC m d r     restart frame
" SPC m d .     debug transient state
" SPC m d a     abandon current session
" SPC m d A     abandon all process
" SPC m d e e   eval
nnoremap <buffer> <CR>dee :Evaluate<Space>
" SPC m d e r   eval region
vnoremap <buffer> <CR>der :Evaluate<CR>
" SPC m d e t   eval value at point
nnoremap <buffer> <CR>det :Evaluate<CR>
" SPC m d S s   switch session
" SPC m d S t   switch thread
" SPC m d S f   switch frame
" SPC m d I i   inspect
nnoremap <buffer> <CR>dIi :Evaluate<Space>
" SPC m d I r   inspect region
vnoremap <buffer> <CR>dIr :Evaluate<CR>
" SPC m d I t   inspect value at point
nnoremap <buffer> <CR>dIt :Evaluate<CR>
" SPC m d b b   toggle a breakpoint
" SPC m d b c   change breakpoint condition
" SPC m d b l   change breakpoint log condition
" SPC m d b h   change breakpoint hit count
" SPC m d b a   add a breakpoint
nnoremap <buffer> <CR>dba :Break<CR>
" SPC m d b d   delete a breakpoint
nnoremap <buffer> <CR>dbd :Clear<CR>
" SPC m d b D   clear all breakpoints
" SPC m d '_    Run debug REPL
" SPC m d w l   list local variables
nnoremap <buffer> <CR>dwl :call TermDebugSendCommand('info locals')<CR>
" SPC m d w o   goto output buffer if present
nnoremap <buffer> <CR>dwo :Program<CR>
" SPC m d w s   list sessions
" SPC m d w b   list breakpoints
nnoremap <buffer> <CR>dwb :call TermDebugSendCommand('info breakpoints')<CR>

" nnoremap <buffer> K :call LanguageClient#textDocument_hover()<CR>
nmap <buffer> <CR>hh :call LanguageClient#textDocument_hover()<CR>

nnoremap <buffer> \\<F1> :!xdg-open "https://en.cppreference.com/w/cpp"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> \\?1 :!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?1 "*y<Esc>:!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> \\?2 :!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?2 "*y<Esc>:!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" toggle between source and header
" (TODO)
" SPC m g a     open matching file (e.g. switch between .cpp and .h)
" SPC m g A     open matching file in another window (e.g. switch between .cpp and .h)
" FIXME this doesn't work!
nmap <buffer> <CR>ga :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>

" nnoremap <buffer> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> <CR><CR> :call LanguageClient#textDocument_definition()<CR>
nmap <buffer> <CR>gg <CR><CR>

nnoremap <buffer> <CR>rr :call LanguageClient#textDocument_rename()<CR>

" SPC m D   disaster: disassemble c/c++ code

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

" Key bindings from develop.spacemacs.org
" ---------------------------------------
" 3 Key bindings
" Key binding   Description
" SPC m g a     open matching file
"       (e.g. switch between .cpp and .h, requires a project to work)
" SPC m g A     open matching file in another window
"       (e.g. switch between .cpp and .h, requires a project to work)
" SPC m D   disaster: disassemble c/c++ code
" SPC m r .     srefactor: refactor thing at point.
" SPC m r i     organize includes

" Note: semantic-refactor is only available for Emacs 24.4+.
" 3.1 Formatting (clang-format)
" Key binding   Description
" SPC m = =     format current region or buffer
" SPC m = f     format current function
" 3.2 RTags
" Key binding   Description
" SPC m g .     find symbol at point
" SPC m g ,     find references at point
" SPC m g ;     find file
" SPC m g /     find all references at point
" SPC m g [     location stack back
" SPC m g ]     location stack forward
" SPC m g >     c++ tags find symbol
" SPC m g <     c++ tags find references
" SPC m g B     show rtags buffer
" SPC m g d     print dependencies
" SPC m g D     diagnostics
" SPC m g e     reparse file
" SPC m g E     preprocess file
" SPC m g F     fixit
" SPC m g G     guess function at point
" SPC m g h     print class hierarchy
" SPC m g I     c++ tags imenu
" SPC m g L     copy and print current location
" SPC m g M     symbol info
" SPC m g O     goto offset
" SPC m g p     set current project
" SPC m g R     rename symbol
" SPC m g s     print source arguments
" SPC m g S     display summary
" SPC m g T     taglist
" SPC m g v     find virtuals at point
" SPC m g V     print enum value at point
" SPC m g X     fix fixit at point
" SPC m g Y     cycle overlays on screen
" 3.3 cquery / ccls

" The key bindings listed below are in addition to the default key bindings defined by the LSP layer. A [ccls] or [cquery] suffix indicates that the binding is for the indicated backend only.
" 3.3.1 backend (language server)
" Key binding   Description
" SPC m b f     refresh index (e.g. after branch change)
" SPC m b p     preprocess file
" 3.3.2 goto
" Key binding   Description
" SPC m g &     find references (address)
" SPC m g R     find references (read)
" SPC m g W     find references (write)
" SPC m g c     find callers
" SPC m g C     find callees
" SPC m g v     vars
" SPC m g f     find file at point (ffap)
" SPC m g F     ffap other window

"     goto/hierarchy
"     Key binding   Description
"     SPC m g h b   base class(es)
"     SPC m g h d   derived class(es) [ccls]
"     SPC m g h c   call hierarchy
"     SPC m g h C   call hierarchy (inv)
"     SPC m g h i   inheritance hierarchy
"     SPC m g h I   inheritance hierarchy (inv)
"     goto/member
"     Key binding   Description
"     SPC m g m h   member hierarchy
"     SPC m g m t   member types [ccls]
"     SPC m g m f   member functions [ccls]
"     SPC m g m v   member variables [ccls]
