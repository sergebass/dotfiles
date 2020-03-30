""" -------------------------------
""" Java-specific vim configuration
""" -------------------------------

runtime! sergebass/sergebass-eclim.vim

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
 
" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
nnoremap <buffer> <F1> :!xdg-open "https://docs.oracle.com/javase/8/docs/api/"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://docs.oracle.com/javase/10/docs/api/index.html"<CR>

setlocal keywordprg=:JavaDocPreview

nnoremap <buffer> K :JavaDocPreview<CR>
nmap <buffer> <Space>mhh K

" These are spacemacs keybindings for java mode: TODO incorporate them here...

" 3.1.2 Eclimd
" SPC m d s     Start daemon
" SPC m d k     Stop daemon

" 3.1.1 Project management
" SPC m p b     Build project
" SPC m p c     Create project
" SPC m p d     Delete project
" SPC m p g     Open file in current project
" SPC m p i     Import project
" SPC m p j     Information about project
" SPC m p k     Close project
" SPC m p o     Open project
" SPC m p p     Open project management buffer
" SPC m p u     Update project

" 3.1.3 Maven
" SPC m m i     Run maven clean install
" SPC m m I     Run maven install
" SPC m m p     Run one already goal from list
" SPC m m r     Run maven goals
" SPC m m R     Run one maven goal
" SPC m m t     Run maven test

" 3.1.7 Problems
" SPC m e a     set all problems for next/prev action
" SPC m e b     open buffer with problems
" SPC m e c     show options with problem corrections
" SPC m e e     set only errors for next/prev action
" SPC m e f     set only current file for next/prev action
" SPC m e n     go to next problem
" SPC m e o     open buffer with problems
" SPC m e p     go to previous problem
" SPC m e w     set warnings for next/prev action

" search the term under cursor on the web
nnoremap <buffer> \\? :!xdg-open "https://duckduckgo.com?q=<C-r>=expand("<cword>")<CR> Java API"<Left>
vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://duckduckgo.com?q=<C-r>* Java API"<Left>

nnoremap <buffer> <Space>mff :LocateFile<CR>

nnoremap <buffer> <CR><CR> :JavaSearchContext -a edit<CR>
nmap <buffer> <Space>mgg <CR><CR>

" 3.1.4 Goto
" M-,   jump back from go to declaration/definition
" SPC m g g     go to declaration
" SPC m g t     go to type definition

" quickly search the word under cursor using eclim (Eclipse's Ctrl+Shift+G analog)
nnoremap <buffer> \<CR> :JavaSearch -a edit -x all -s all -t all<CR>:cfirst<CR>
nmap <buffer> <Space>mhu \<CR>

" search the word under cursor in external files (Java sources only,
" ripgrep is assumed to be the underlying search engine)
nnoremap <buffer> \\/ :let w=expand("<cword>")<CR><CR>:grep -s -w -t java <C-r>=w<CR>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap <buffer> \\/ "*y<Esc>:grep -s -t java "<C-r>*"<Left>

" Let the user customize search parameters of these commands
nnoremap <buffer> \\s :JavaSearch<Space>
nnoremap <buffer> \\ss :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x all -s all -t all
nnoremap <buffer> \\sd :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x declarations -s all -t all
nnoremap <buffer> \\si :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x implementors -s all -t all
nnoremap <buffer> \\sr :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x references -s all -t all

nnoremap <buffer> \\< :JavaCallHierarchy<CR>
nnoremap <buffer> \\> :JavaCallHierarchy!<CR>

nnoremap <buffer> \\^ :JavaHierarchy<CR>

nnoremap <buffer> \\o :JavaOutline<CR>

nnoremap <buffer> \\jd :JavaDocComment<CR>

nnoremap <buffer> \\nc :JavaNew class<Space>
nnoremap <buffer> \\ni :JavaNew interface<Space>
nnoremap <buffer> \\na :JavaNew abstract<Space>
nnoremap <buffer> \\ne :JavaNew enum<Space>
nnoremap <buffer> \\n@ :JavaNew @interface<Space>

" these mappings work both in normal and visual mode
noremap <buffer> \\mc :JavaConstructor<CR>
noremap <buffer> \\mc! :JavaConstructor!<CR>
noremap <buffer> \\mg :JavaGet<CR>
noremap <buffer> \\mg! :JavaGet!<CR>
noremap <buffer> \\ms :JavaSet<CR>
noremap <buffer> \\ms! :JavaSet!<CR>
noremap <buffer> \\mgs :JavaGetSet<CR>
noremap <buffer> \\mgs! :JavaGetSet!<CR>

nnoremap <buffer> \\mi :JavaImpl<CR>
nnoremap <buffer> \\md :JavaDelegate<CR>

nnoremap <buffer> <Space>mtt :JUnit<CR>
nnoremap <buffer> \\T :JUnitFindTest<CR>

nnoremap <buffer> \\1 :JavaCorrect<CR>

" refactoring
nnoremap <buffer> <Space>mrm :JavaMove<Space>
nnoremap <buffer> <Space>mrr :JavaRename<Space>
nnoremap <buffer> <Space>mru :RefactorUndo<CR>
nnoremap <buffer> <Space>mri :JavaImportOrganize<CR>
nnoremap <buffer> <Space>mrf :%JavaFormat<CR>

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

nnoremap <buffer> \\d? :JavaDebugStatus<CR>
nnoremap <buffer> <F12> :JavaDebugStatus<CR>

nnoremap <buffer> \\ds :JavaDebugStart localhost 8888
nnoremap <buffer> \\dq :JavaDebugStop<CR>
nnoremap <buffer> <C-F2> :JavaDebugStop<CR>

nnoremap <buffer> \\db :JavaDebugBreakpointToggle<CR>
nnoremap <buffer> <F9> :JavaDebugBreakpointToggle<CR>

" disable and delete breakpoints
nnoremap <buffer> \\db! :JavaDebugBreakpointToggle!<CR>

" for current file
nnoremap <buffer> \\dbl :JavaDebugBreakpointsList<CR>

" for current project
nnoremap <buffer> \\dbl! :JavaDebugBreakpointsList!<CR>
nnoremap <buffer> <F10> :JavaDebugBreakpointsList!<CR>

" all breakpoints in the current file
nnoremap <buffer> \\dbr :JavaDebugBreakpointRemove<CR>

" all breakpoints for current project
nnoremap <buffer> \\dbr! :JavaDebugBreakpointRemove!<CR>

nnoremap <buffer> <F5> :JavaDebugStep into<CR>
nnoremap <buffer> <F6> :JavaDebugStep over<CR>
nnoremap <buffer> <F7> :JavaDebugStep return<CR>
nnoremap <buffer> <F8> :JavaDebugThreadResume<CR>

nnoremap <buffer> \\dtsa :JavaDebugThreadSuspendAll<CR>
nnoremap <buffer> \\dtra :JavaDebugThreadResumeAll<CR>

" Useful abbreviations

iabbrev <buffer> __core import static java.util.Arrays.*;<CR>
                       \import static java.util.Objects.*;<CR>
                       \import static java.util.Collections.*;<CR>
                       \import static java.util.stream.Collectors.*;<CR>
                       \import static java.util.function.Function.*;<CR>

iabbrev <buffer> __junit import static org.junit.Assert.*;<CR>
                        \import static org.junit.Assume.*;<CR>

iabbrev <buffer> __hamcrest import static org.hamcrest.CoreMatchers.*;<CR>

iabbrev <buffer> __easymock import static org.easymock.EasyMock.*;<CR>

iabbrev <buffer> __apache import static org.apache.commons.collections.CollectionUtils.*;<CR>
                         \import static org.apache.commons.lang.StringUtils.*;<CR>

iabbrev <buffer> __guava import static com.google.common.base.Preconditions.*;<CR>
                        \import static com.google.common.collect.Collections2.*;<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific Java settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-java.vim"))
    source ~/.workspace-java.vim
endif
