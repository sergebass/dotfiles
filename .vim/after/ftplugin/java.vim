""" ---------------------------
""" JAVA-SPECIFIC CONFIGURATION
""" ---------------------------

" error format for ant/javac
setlocal efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

" Java/Eclim debug configuration
" 
"     g:EclimJavaDebugLineHighlight (Default: ‘DebugBreak’) Highlight group to use for showing the current line being debugged.
" 
"     g:EclimJavaDebugLineSignText (Default: ‘•’) Text to use on sign column for showing the current line being debugged.
" 
"     g:EclimJavaDebugStatusWinOrientation (Default: ‘vertical’) Sets the orientation for the splits inside the debug status windows; if they should be tiled vertically or horizontally. Possible values: - horizontal - vertical
" 
"     g:EclimJavaDebugStatusWinWidth (Default: 50) Sets the window width for the splits inside the debug status window. This is only applicable when the orientation is horizontal.
" 
"     g:EclimJavaDebugStatusWinHeight (Default: 10) Sets the window height for the splits inside the debug status window. This is only applicable when the orientation is vertical.
 
setlocal keywordprg=:JavaDocPreview

nnoremap <buffer> K :JavaDocPreview<CR>

nnoremap <buffer> <F1> :!xdg-open "https://docs.oracle.com/javase/8/docs/api/"<CR>

nnoremap <buffer> <CR> :JavaSearchContext -a edit<CR>
nnoremap <buffer> <F3> :JavaSearchContext -a edit<CR>
nnoremap <buffer> <C-LeftMouse> :JavaSearchContext -a edit<CR>

nnoremap <buffer> <LocalLeader>ff :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x all -s all -t all
nnoremap <buffer> <LocalLeader>fd :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x declarations -s all -t all
nnoremap <buffer> <LocalLeader>fi :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x implementors -s all -t all
nnoremap <buffer> <LocalLeader>fr :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x references -s all -t all

nnoremap <buffer> <LocalLeader>^ :JavaHierarchy<CR>

nnoremap <buffer> <LocalLeader>< :JavaCallHierarchy<CR>
nnoremap <buffer> <LocalLeader>> :JavaCallHierarchy!<CR>

nnoremap <buffer> <LocalLeader>jd :JavaDocComment<CR>

nnoremap <buffer> <LocalLeader>rm :JavaMove<Space>
nnoremap <buffer> <LocalLeader>rr :JavaRename<Space>
nnoremap <buffer> <LocalLeader>ru :RefactorUndo<CR>

nnoremap <buffer> <LocalLeader>nc :JavaNew class<Space>
nnoremap <buffer> <LocalLeader>ni :JavaNew interface<Space>
nnoremap <buffer> <LocalLeader>na :JavaNew abstract<Space>
nnoremap <buffer> <LocalLeader>ne :JavaNew enum<Space>
nnoremap <buffer> <LocalLeader>n@ :JavaNew @interface<Space>

" these mappings work both in normal and visual mode
noremap <buffer> <LocalLeader>mc :JavaConstructor<CR>
noremap <buffer> <LocalLeader>mc! :JavaConstructor!<CR>
noremap <buffer> <LocalLeader>mg :JavaGet<CR>
noremap <buffer> <LocalLeader>mg! :JavaGet!<CR>
noremap <buffer> <LocalLeader>ms :JavaSet<CR>
noremap <buffer> <LocalLeader>ms! :JavaSet!<CR>
noremap <buffer> <LocalLeader>mgs :JavaGetSet<CR>
noremap <buffer> <LocalLeader>mgs! :JavaGetSet!<CR>

nnoremap <buffer> <LocalLeader>mi :JavaImpl<CR>
nnoremap <buffer> <LocalLeader>md :JavaDelegate<CR>

nnoremap <buffer> <LocalLeader>t :JUnit %

nnoremap <buffer> <LocalLeader>1 :JavaCorrect<CR>

nnoremap <buffer> <LocalLeader>i :JavaImportOrganize<CR>

nnoremap <buffer> <LocalLeader>= :%JavaFormat<CR>
vnoremap <buffer> <LocalLeader>= :JavaFormat<CR>

" Eclim documentation page: http://eclim.org/vim/java/debug.html
"
" Before starting a debug session from vim you first need to do a couple things:
" 
"     Start your java program with the debugging hooks enabled:
" 
" $ java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
"     -classpath ./bin org.test.debug.Main
" 
"     Start vim with the --servername argument (eclimd currently sends debugger updates to vim using vim’s remote invocation support):
" 
" $ vim --servername debug ...
" 
" Note: The server name you choose doesn’t matter as long as you don’t have another vim instance running with that same name.

nnoremap <buffer> <LocalLeader>d? :JavaDebugStatus<CR>
nnoremap <buffer> <F12> :JavaDebugStatus<CR>

nnoremap <buffer> <LocalLeader>ds :JavaDebugStart localhost 8888
nnoremap <buffer> <LocalLeader>dq :JavaDebugStop<CR>
nnoremap <buffer> <C-F2> :JavaDebugStop<CR>

nnoremap <buffer> <LocalLeader>db :JavaDebugBreakpointToggle<CR>
nnoremap <buffer> <F9> :JavaDebugBreakpointToggle<CR>

" disable and delete breakpoints
nnoremap <buffer> <LocalLeader>db! :JavaDebugBreakpointToggle!<CR>

" for current file
nnoremap <buffer> <LocalLeader>dbl :JavaDebugBreakpointsList<CR>

" for current project
nnoremap <buffer> <LocalLeader>dbl! :JavaDebugBreakpointsList!<CR>
nnoremap <buffer> <F10> :JavaDebugBreakpointsList!<CR>

" all breakpoints in the current file
nnoremap <buffer> <LocalLeader>dbr :JavaDebugBreakpointRemove<CR>

" all breakpoints for current project
nnoremap <buffer> <LocalLeader>dbr! :JavaDebugBreakpointRemove!<CR>

nnoremap <buffer> <F5> :JavaDebugStep into<CR>
nnoremap <buffer> <F6> :JavaDebugStep over<CR>
nnoremap <buffer> <F7> :JavaDebugStep return<CR>
nnoremap <buffer> <F8> :JavaDebugThreadResume<CR>

nnoremap <buffer> <LocalLeader>dtsa :JavaDebugThreadSuspendAll<CR>
nnoremap <buffer> <LocalLeader>dtra :JavaDebugThreadResumeAll<CR>
