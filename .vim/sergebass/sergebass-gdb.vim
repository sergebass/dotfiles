""" --------------------------------------------
""" Shared configuration for gdb-based debugging
""" --------------------------------------------

" While our debugging infrastructure is being developed, just use simple helpers 
" to get current file and line number for gdb and lldb, respectively,
" and copy them to clipboard (to paste them right into the debugger)
nnoremap <buffer> \\bl :let @+=expand("%") . ":" . line(".")<CR>:echo @+<CR>
nnoremap <buffer> \\bL :let @+="-f " . expand("%") . " -l " . line(".")<CR>:echo @+<CR>

" FIXME a bit hacky, but direct breakpoint setting for LLDB, the "lldb" window name is hardcoded too
nnoremap <buffer> \\BL :!tmux send-keys -t "lldb" "breakpoint set -f <C-R>=expand("%")<CR> -l <C-R>=line('.')<CR>" Enter<CR>

" FIXME should this be in global configuration instead?
" This is a new feature in vim to better integrate with gdb
packadd termdebug

" Use gdb as our debugger
let termdebugger = "gdb"

" FIXME should this be in global configuration instead?
" FIXME configure this:
" let g:termdebug_wide = 163

" :Run [args]      run the program with [args] or the previous arguments
nnoremap <buffer> <F12> :Run<CR>
" :Arguments {args}  set arguments for the next `:Run`

" (the shortcuts for quick navigation between debugger, program output and source during debugging
" are defined in the main mapping file)

" :Break " set a breakpoint at the current line; a sign will be displayed
nnoremap <buffer> \\' :Break<CR>
nnoremap <buffer> <F9> :Break<CR>

" :Clear " delete the breakpoint at the current line
nnoremap <buffer> \\" :Clear<CR>
nnoremap <buffer> <F10> :Clear<CR>

" :Over    execute the gdb "next" command (`:Next` is a Vim command)
" nnoremap <buffer> <M-;> :Over<CR>
nnoremap <buffer> <F5> :Over<CR>

" :Step    execute the gdb "step" command
" nnoremap <buffer> <M-'> :Step<CR>
nnoremap <buffer> <F6> :Step<CR>

" :Finish  execute the gdb "finish" command
" nnoremap <buffer> <M-,> :Finish<CR>
nnoremap <buffer> <F7> :Finish<CR>

" :Continue    execute the gdb "continue" command
" nnoremap <buffer> <M-.> :Continue<CR>
nnoremap <buffer> <F8> :Continue<CR>

" :Evaluate
" :'<,'>Evaluate` "evaluate the Visually selected text
" nnoremap <buffer> <M-=> :Evaluate<CR>
" vnoremap <buffer> <M-=> :Evaluate<CR>
" nnoremap <buffer> <RightMouse> :Evaluate<CR>

nnoremap <buffer> \\dt :call TermDebugSendCommand('info threads')<CR>
nnoremap <buffer> \\dl :call TermDebugSendCommand('info locals')<CR>
nnoremap <buffer> \\db :call TermDebugSendCommand('info breakpoints')<CR>
nnoremap <buffer> \\dr :call TermDebugSendCommand('info registers')<CR>
nnoremap <buffer> \\df :call TermDebugSendCommand('frame')<CR>
nnoremap <buffer> \\ds :call TermDebugSendCommand('backtrace')<CR>

" Debugging keybindings from develop.spacemacs.org
" ------------------------------------------------
" SPC m d d d   start debugging
nnoremap <buffer> <Space>mddd :Termdebug<CR>
" SPC m d d l   debug last configuration
" SPC m d d r   debug recent configuration
" SPC m d c     continue
nnoremap <buffer> <Space>mdc :Continue<CR>
" SPC m d i     step in
nnoremap <buffer> <Space>mdi :Step<CR>
" SPC m d o     step out
nnoremap <buffer> <Space>mdo :Finish<CR>
" SPC m d s     next step
nnoremap <buffer> <Space>mds :Over<CR>
" SPC m d v     inspect value at point
nnoremap <buffer> <Space>mdv :Evaluate<CR>
" SPC m d r     restart frame
" SPC m d .     debug transient state
" SPC m d a     abandon current session
nnoremap <buffer> <Space>mda :Stop<CR>
" SPC m d A     abandon all process
nnoremap <buffer> <Space>mdA :Stop<CR>
" SPC m d e e   eval
nnoremap <buffer> <Space>mdee :Evaluate<Space>
" SPC m d e r   eval region
vnoremap <buffer> <Space>mder :Evaluate<CR>
" SPC m d e t   eval value at point
nnoremap <buffer> <Space>mdet :Evaluate<CR>
" SPC m d S s   switch session
" SPC m d S t   switch thread
" SPC m d S f   switch frame
" SPC m d I i   inspect
nnoremap <buffer> <Space>mdIi :Evaluate<Space>
" SPC m d I r   inspect region
vnoremap <buffer> <Space>mdIr :Evaluate<CR>
" SPC m d I t   inspect value at point
nnoremap <buffer> <Space>mdIt :Evaluate<CR>
" SPC m d b b   toggle a breakpoint
nnoremap <buffer> <Space>mdbb :Break<CR>
" SPC m d b c   change breakpoint condition
" SPC m d b l   change breakpoint log condition
" SPC m d b h   change breakpoint hit count
" SPC m d b a   add a breakpoint
nnoremap <buffer> <Space>mdba :Break<CR>
" SPC m d b d   delete a breakpoint
nnoremap <buffer> <Space>mdbd :Clear<CR>
" SPC m d b D   clear all breakpoints
" SPC m d '_    Run debug REPL
" SPC m d w l   list local variables
nnoremap <buffer> <Space>mdwl :call TermDebugSendCommand('info locals')<CR>
" SPC m d w o   goto output buffer if present
nnoremap <buffer> <Space>mdwo :Program<CR>
" SPC m d w s   list sessions
" SPC m d w b   list breakpoints
nnoremap <buffer> <Space>mdwb :call TermDebugSendCommand('info breakpoints')<CR>
