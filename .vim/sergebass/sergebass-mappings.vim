""" -----------------
""" KEYBOARD MAPPINGS
""" -----------------

" Allow saving of files as sudo if we forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" since "S" is equivalent to "cc", reuse it to save all buffers
nnoremap S :wa<CR>

" since "Q" is equivalent to "gQ" and is rarely used, reuse it to close all windows and quit
nnoremap Q :qa<CR>

" since "Y" is normally equivalent to "yy", make Y copy to the end of line:
" (this will be more consistent with C or D that also act until the end of line)
nnoremap Y y$

" an alternative way to quickly save the file being edited
" (make sure to turn off terminal flow control via Ctrl+S/Q)
inoremap <C-S> <C-O>:update<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>

" since "C-Q" is equivalent to "C-V", use <C-Q> to delete current buffer
nnoremap <C-Q> :bdelete<CR>

" copying/pasting/deleting tweaks

" in normal mode:
nnoremap \y "+y
nnoremap \Y "+y$

nnoremap \p "+p
nnoremap \P "+P

nnoremap \d "_d
nnoremap \D "_d$

" in visual mode:
vnoremap \y "+y

vnoremap \p "_d"+p
vnoremap \P "_d"+P

vnoremap \d "_d

" we can still use the "x" command for the traditional operation,
" so let's tweak Del to act like in non-modal editors (just delete, not save):
vnoremap <Del> "_d
nnoremap <Del> "_x

" session management accelerators (don't forget to add .vim extension!)
nnoremap \# :mksession! Session
nnoremap \@ :source Session

nnoremap <C-N> :Tags<CR>
nnoremap <C-P> :GFiles<CR>

nnoremap <BS> <C-O>

" for quicker navigation between location with changes
nnoremap <M-Tab> g,
nnoremap <M-BS> g;

" emulate Spacemacs/SpaceVim

nnoremap <Space><Space> :
nnoremap <Space><Tab> <C-^>

" make mode-specific mappings a bit shorter, use another big button as a prefix
silent! unmap <CR>
nmap <Space>m <CR>

nnoremap <Space>h<Space> :h<CR>
nnoremap <Space>? :Maps<CR>
nnoremap <Space>hk :Maps<CR>
nnoremap <Space>hi :h <C-r>=expand("<cword>")<CR><CR>

nnoremap <Space>qq :qa<CR>
nnoremap <Space>qQ :qa!<CR>

nnoremap <Space>ff :Files<CR>
nnoremap <Space>fr :call fzf#vim#history()<CR>
nnoremap <Space>fs :w<CR>
nnoremap <Space>fS :wa<CR>
nnoremap <Space>fy <C-G>
nnoremap <Space>ft :NERDTreeToggle<CR>
nnoremap <Space>fed :new<CR>:e $MYVIMRC<CR>
if has("win32")
    nnoremap <Space>fei :new<CR>:e ~/vimfiles/vimrc<CR>
else
    nnoremap <Space>fei :new<CR>:e ~/.vim/vimrc<CR>
endif

nnoremap <Space>bb :call fzf#vim#buffers()<CR>
nnoremap <Space>bd :bdelete<CR>
nnoremap <Space>bn :bnext<CR>
nnoremap <Space>bp :bprev<CR>
nnoremap <Space>bR :e!
nnoremap <Space>bY gg"+yG
nnoremap <Space>bP ggvG"+p

nnoremap <Space>ss :BLines<CR>
nnoremap <Space>sb :Lines<CR>
nnoremap <Space>/ :Rg<CR>
nnoremap <Space>sp :Rg<CR>
nnoremap <Space>sap :Ag<CR>
nnoremap <Space>* :let w=expand("<cword>")<CR><CR>:Rg <C-r>=w<CR><CR>
nnoremap <Space>sP :Rg<CR>
nnoremap <Space>saP :Ag<CR>

nmap <Space>p' <Space>'
nnoremap <Space>pf :GFiles<CR>
nnoremap <Space>pr :GFiles?<CR>
nnoremap <Space>pt :NERDTreeFind<CR>
nnoremap <Space>pg :Tags<CR>
nnoremap <Space>pc :make<CR>
nnoremap <Space>pr :make clean<CR>
nnoremap <Space>pT :make test<CR>
nnoremap <Space>pG :!ctags -R<CR>
nmap <Space>pF gF

" project building (using makeprg variable, possibly pre-configured via an .lvimrc project file)
nnoremap <Space>cm :make<CR>
nmap <Space>cc <Space>pc
nmap <Space>cr <Space>pr

" error navigation
nnoremap <Space>el :cw<CR>
nnoremap <Space>en :cnext<CR>
nnoremap <Space>ep :cprev<CR>
nnoremap <Space>ec :ClearQuickfixList<CR>

" code commenting
vmap <Space>; gc
nmap <Space>cl gcc

" spacemacs-compatible quick shortcuts for vim-fugitive
nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>gl :Glog<CR>
nnoremap <Space>gd :Gdiff<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gg :Ggrep<Space>
nnoremap <Space>gfh :execute 'new <bar> 0r !git log -p #'<CR>:set readonly filetype=git buftype=nofile<CR>gg
nnoremap <Space>gS :!git add %<CR>
nnoremap <Space>gU :!git reset %<CR>

" remaining unimplemented spacemacs mappings for git
" SPC g >   show submodule prompt
" SPC g H c     clear highlights
" SPC g H h     highlight regions by age of commits
" SPC g H t     highlight regions by last updated time
" SPC g I   open helm-gitignore
" SPC g m   magit dispatch popup
" SPC g M   display the last commit message of the current line
" SPC g t   launch the git time machine

" SPC g l c     on a commit hash, browse to the current file at this commit
" SPC g l C     on a commit hash, create link to the file at this commit and copy it
" SPC g l l     on a region, browse to file at current lines position
" SPC g l L     on a region, create a link to the file highlighting the selected lines

" spacemacs diff mode mappings (from development branch):
" SPC m a   Apply a hunk
" SPC m d   Kill the hunk at point
" SPC m D   Kill the current file's hunk
" SPC m e   Call ediff-patch-file on current buffer
" SPC m f c     Convert unified diffs to context diffs
" SPC m f r     Reverse the direction of the diffs
" SPC m f u     Convert context diffs to unified diffs
" SPC m g   Jump to the corresponding source line
" SPC m j   Next hunk
" SPC m J   Next file
" SPC m k   Previous hunk
" SPC m K   Previous file
" SPC m q   Close the diff window
" SPC m r   Revert a hunk
" SPC m s   Split the current hunk at point into two hunks
" SPC m u   Undo" non-Spacemacs useful git mappings (for both vim-fugitive and vim-gitgutter)

" shortcuts to navigate between merge conflicts and pull chunks from local/remote/base versions into the merged one
" (stay in the merged file buffer and apply for each of the conflict chunk)
nnoremap \g[ ?<<<<<<< <CR>
nnoremap \g] /<<<<<<< <CR>
nnoremap \gL :diffget _LOCAL_<CR>
nnoremap \gR :diffget _REMOTE_<CR>
nnoremap \gB :diffget _BASE_<CR>

nnoremap \gm :Gmove<Space>
nnoremap \gr :Grename<Space>
nnoremap \gx :Gbrowse<CR>
nnoremap \gza :GitGutterFold<CR>
nnoremap \ghp :GitGutterPreviewHunk<CR>
nnoremap \ghs :GitGutterStageHunk<CR>
nnoremap \ghu :GitGutterUndoHunk<CR>

" An easier way to see git change history for a current line or selection
nnoremap \gfh :execute 'new <bar> 0r !git log -p #'<CR>:set readonly filetype=git buftype=nofile<CR>gg
vnoremap \gfh :<C-u>execute 'new <bar> 0r !git log -L <C-r>=line("'<")<CR>,<C-r>=line("'>")<CR>:#'<CR>:set readonly filetype=git buftype=nofile<CR>gg

" looking up file history in subversion
nnoremap \sfh :execute 'new <bar> 0r !svn log -v --diff #'<CR>:set readonly filetype=svn buftype=nofile<CR>gg
nnoremap \sfb :execute 'new <bar> 0r !svn ann -v #'<CR>:set readonly filetype=svn buftype=nofile<CR>gg

" miscellaneous UI toggles
nnoremap <Space>tn :set number!<CR>
nnoremap <Space>thh :set cursorline!<CR>
nnoremap <Space>thc :set cursorcolumn!<CR>

" the stock shortcut to exit terminal mode is cumbersome, let's change it
" use the same shortcut for convenience
if has('nvim') || (v:version >= 800)
    if has("win32")
        nnoremap <silent> <Space>' :vsplit term://cmd.exe<CR>
    else
        nnoremap <silent> <Space>' :vsplit term://$SHELL<CR>
    endif

    " the shortcut to yield control from terminal to (n)vim
    tnoremap <C-\> <C-\><C-n>

    "shortcuts for quick navigation between debugger, program output and source during debugging
    " :Gdb " jump to the gdb window
    noremap <F2> :Gdb<CR>
    " :Program "jump to the window with the running program
    noremap <F3> :Program<CR>
    " :Source "jump to the window with the source code, create it if there isn't one
    noremap <F4> :Source<CR>

endif

" use \ with numeric keys to simulate finctional keys,
" for use on terminals/machines where Fn keys are missing (e.g. Chromebook)
noremap <silent> \1 <F1>
noremap <silent> \2 <F2>
noremap <silent> \3 <F3>
noremap <silent> \4 <F4>
noremap <silent> \5 <F5>
noremap <silent> \6 <F6>
noremap <silent> \7 <F7>
noremap <silent> \8 <F8>
noremap <silent> \9 <F9>
noremap <silent> \0 <F10>

noremap <silent> \\1 \<F1>
noremap <silent> \\2 \<F2>
noremap <silent> \\3 \<F3>
noremap <silent> \\4 \<F4>
noremap <silent> \\5 \<F5>
noremap <silent> \\6 \<F6>
noremap <silent> \\7 \<F7>
noremap <silent> \\8 \<F8>
noremap <silent> \\9 \<F9>
noremap <silent> \\0 \<F10>

" navigation mappings

" Tab navigation (using Meta/Alt key)
nnoremap <silent> <M-[> :tabprev<CR>
nnoremap <silent> <M-]> :tabnext<CR>

" a quick way to navigate between tabs
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt
nnoremap <M-0> 10gt

" move between windows (without arrows)
nnoremap <silent> <M-h> <C-w>h
nnoremap <silent> <M-l> <C-w>l
nnoremap <silent> <M-k> <C-w>k
nnoremap <silent> <M-j> <C-w>j

" make arrow keys work on screen lines (useful for wrapped long lines);
" the traditional {hjkl}/g{hjkl} behave as usual (logical lines)

noremap  <silent> <Up>   gk
noremap  <silent> <Down> gj
noremap  <silent> <Home> g<Home>
noremap  <silent> <End>  g<End>

" use Alt with input mode overridings since non-modified ones interfere with autocompletion
inoremap <silent> <M-Up>   <C-o>gk
inoremap <silent> <M-Down> <C-o>gj
inoremap <silent> <M-Home> <C-o>g<Home>
inoremap <silent> <M-End>  <C-o>g<End>

" enable CamelCase navigation
let g:camelchar = "A-Z0-9_.,;:{([<`'\""

nnoremap <silent> <S-Left> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent> <S-Right> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent> <S-Left> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent> <S-Right> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
vnoremap <silent> <S-Left> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
vnoremap <silent> <S-Right> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o

" Move CamelCase with H & L but only as text-object
onoremap <silent> H :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
onoremap <silent> L :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>

" Make jumping to the next method/function faster (for languages with Java/C++ style curly braces)
nnoremap <silent> <C-j> ]m
nnoremap <silent> <C-k> [m

" Window manipulation/navigation

" A duplicate of Ctrl+W for in-browser SSH use (Ctrl+W closes browser tabs normally)
nnoremap <Space>w <C-w>

" a quicker way to hide and maximize windows
noremap <silent> + <C-w>o
noremap <silent> _ <C-w>c

" move between windows (spacemacs space prefix, with arrows)
nnoremap <silent> <Space><Left> <C-w>h
nnoremap <silent> <Space><Right> <C-w>l
nnoremap <silent> <Space><Up> <C-w>k
nnoremap <silent> <Space><Down> <C-w>j

" a quick way to navigate between tabs (spacemacs prefix, serial)
nnoremap <Space>1 1gt
nnoremap <Space>2 2gt
nnoremap <Space>3 3gt
nnoremap <Space>4 4gt
nnoremap <Space>5 5gt
nnoremap <Space>6 6gt
nnoremap <Space>7 7gt
nnoremap <Space>8 8gt
nnoremap <Space>9 9gt
nnoremap <Space>0 10gt

" Tab navigation (for reduced keyboards)
nnoremap <silent> <Space><CR> :tabnew<CR>
nnoremap <silent> <Space><M-CR> :tabnew<CR>:tabmove 0<CR>
nnoremap <silent> <Space><BS> :tabclose<CR>

" Tab navigation (using spacemacs prefix on bigger keyboards)
nnoremap <silent> <Space><Insert> :tabnew<CR>
nnoremap <silent> <Space><Del> :tabclose<CR>
nnoremap <silent> <Space><Home> :tabfirst<CR>
nnoremap <silent> <Space><End> :tablast<CR>
nnoremap <silent> <Space><PageUp> :tabprev<CR>
nnoremap <silent> <Space><PageDown> :tabnext<CR>

" allow user to choose where to move the tab (empty input causes it to move to the very end)
nnoremap <Space>\ :tabmove<Space>

" quicker way to move tabs
noremap <silent> <M-{> :tabmove-<CR>
noremap <silent> <M-}> :tabmove+<CR>

" resize current window in increments of 4 rows/columns
noremap <silent> <M-<> 4<C-w><
noremap <silent> <M->> 4<C-w>>
noremap <silent> <M-)> 4<C-w>+
noremap <silent> <M-(> 4<C-w>-

" Miscellaneous useful search/navigation stuff

" using FZF
nnoremap <silent> \fzF :Filetypes<CR>
nnoremap <silent> \fz\| :GFiles?<CR>
nnoremap <silent> \fzt :BTags<CR>
nnoremap <silent> \fzg :BCommits<CR>
nnoremap <silent> \fzG :Commits<CR>
nnoremap <silent> \fzw :Windows<CR>
nnoremap <silent> \fzm :Marks<CR>
nnoremap <silent> \fzc :Commands<CR>

" using CtrlP
nnoremap <silent> \pr :CtrlPMRUFiles<CR>
nnoremap <silent> \pf :CtrlP<CR>
nnoremap <silent> \pb :CtrlPBuffer<CR>
nnoremap <silent> \pt :CtrlPTag<CR>
nnoremap <silent> \pm :CtrlPBookmark<CR>
nnoremap <silent> \pc :CtrlPChange<CR>
nnoremap <silent> \px :CtrlPMixed<CR>

" using NERDTree
nnoremap <silent> \<Tab> :NERDTreeFind<CR>
nnoremap <silent> \\<Tab> :NERDTreeToggle<CR>

nnoremap <silent> \\\<Tab> :Lexplore<CR>

nnoremap <silent> \fr :browse oldfiles<CR>

" local tag navigation
nnoremap <silent> \<BS> :TagbarOpen fjc<CR>
nnoremap <silent> \\<BS> :TagbarToggle<CR>
nnoremap <silent> \\\<BS> :MinimapToggle<CR>

nnoremap <silent> gO :TagbarOpen fjc<CR>

" quickly close both quickfix and location list windows
noremap <silent> \_ :lclose<CR>:cclose<CR>

" facilitate quickfix navigation
nnoremap <silent> \[ :cprev<CR>
nnoremap <silent> \] :cnext<CR>
nnoremap <silent> \{ :cpfile<CR>
nnoremap <silent> \} :cnfile<CR>
nnoremap <silent> \( :colder<CR>
nnoremap <silent> \) :cnewer<CR>
nnoremap <silent> \, :cfirst<CR>
nnoremap <silent> \. :clast<CR>
nnoremap <silent> \- :cclose<CR>
nnoremap <silent> \+ :copen<CR>
nnoremap \= :cw<CR>

" clear quickfix list (useful for incremental results of grepadd or vimgrepadd)
nnoremap \<Del> :ClearQuickfixList<CR>

" facilitate location list navigation
nnoremap <silent> \\[ :lprev<CR>
nnoremap <silent> \\] :lnext<CR>
nnoremap <silent> \\{ :lpfile<CR>
nnoremap <silent> \\} :lnfile<CR>
nnoremap <silent> \\( :lolder<CR>
nnoremap <silent> \\) :lnewer<CR>
nnoremap <silent> \\, :lfirst<CR>
nnoremap <silent> \\. :llast<CR>
nnoremap <silent> \\- :lclose<CR>
nnoremap <silent> \\+ :lopen<CR>
nnoremap \\= :lw<CR>

" clear location list (useful for incremental results of lgrepadd or lvimgrepadd)
nnoremap \\<Del> :ClearLocationList<CR>

" quickly reselect just pasted text
nnoremap <silent> gV `[v`]

" This selects the next and the previous closest text object.
map <M-o> <Plug>(wildfire-fuel)
vmap <M-i> <Plug>(wildfire-water)

nmap <2-LeftMouse> <CR><CR>
nmap <M-LeftMouse> gF

" display the number of matches when using "*"
nnoremap \* *<C-O>:%s///gn<CR>``

" define a custom highlighting for the word under cursor or a selection
" in the current buffer
nnoremap \\* :match SPCustomHighlight "<C-r>=expand("<cword>")<CR>"
vnoremap \\* "*y<Esc>:match SPCustomHighlight "<C-r>*"

" define a custom highlighting for the word under cursor or a selection
" in all open buffers
nnoremap \\\* :bufdo match SPCustomHighlight "<C-r>=expand("<cword>")<CR>"
vnoremap \\\* "*y<Esc>:bufdo match SPCustomHighlight "<C-r>*"

" easily copy the word under cursor into the command line being edited
nnoremap <M-CR> :<C-r>=expand("<cword>")<CR>
vnoremap <M-CR> "*y<Esc>:<C-r>*
cnoremap <M-CR> <C-r>=expand("<cword>")<CR>

" replace selected word in the entire file (with confirmation)
nnoremap \R :%s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>
" replace selected word from the current line to the end of file (with confirmation)
nnoremap \r :.,$s/<C-r>=expand("<cword>")<CR>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>

" replace highlighted text in the entire file (with confirmation)
vnoremap \R "hy:%s/<C-r>h/<C-r>=expand("<cword>")<CR>/gc<left><left><left>
" replace highlighted text from the current line to the end of file (with confirmation)
vnoremap \r "hy:.,$s/<C-r>h/<C-r>=expand("<cword>")<CR>/gc<left><left><left>

" by default (may be overridden in format-specific scripts),
" use ctags for jumping, with selection between multiple candidates
nnoremap <CR><CR> g<C-]>
nmap <C-LeftMouse> <CR><CR>

" default mappings for searching the word under cursor, auto-executed
nmap \<CR> \/<CR>
vmap \<CR> \/<CR>

nmap \\<CR> \\/<CR>:copen<CR>
vmap \\<CR> \\/<CR>:copen<CR>

" search the word under cursor in external files (reference search)

" a) using ripgrep (rg)
nnoremap \/ :RgWords <C-r>=expand("<cword>")<CR>
" Rg does not understand quotes, just paste the whole selected chunk as is
" FIXME parentheses need proper quoted to work
vnoremap \/ "*y<Esc>:RgWords <C-r>*

" c) using grep (always available)
nnoremap \\/ :let w=expand("<cword>")<CR><CR>:grep -s -w <C-r>=w<CR>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap \\/ "*y<Esc>:grep -s "<C-r>*"<Left>

" search the word under cursor on the web
nnoremap \? :!xdg-open "https://duckduckgo.com?q=<C-r>=expand("<cword>")<CR> <C-r>=&filetype<CR>"<Left>
vnoremap \? "*y<Esc>:!xdg-open "https://duckduckgo.com?q=<C-r>* <C-r>=&filetype<CR>"<Left>

" search the word under cursor in all open buffers
nnoremap <Space>sB :ClearQuickfixList<CR>:let w=expand("<cword>")<CR><CR>:silent bufdo grepadd! -s -w <C-r>=w<CR> %<Left><Left>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap <Space>sB "*y<Esc>:ClearQuickfixList<CR>:silent bufdo grepadd! -s "<C-r>*" %<Left><Left><Left>

" autocompletion like in many IDEs (Ctrl+Space);
" note that this does not work properly in terminals, only in gvim
inoremap <silent> <C-Space> <C-x><C-u>

" whitespace cleanup: replace tabs with spaces, remove redundant lines, strip all redundant/trailing whitespace
noremap \wt :retab<CR>

nnoremap \ws :RemoveAllRedundantWhitespace<CR>
vnoremap \ws :<C-w>RemoveSelectedRedundantWhitespace<CR>

nnoremap \wl :RemoveAllMultipleBlankLines<CR>
vnoremap \wl :<C-w>RemoveSelectedMultipleBlankLines<CR>

nnoremap \ww :retab<CR>:RemoveAllMultipleBlankLines<CR>:RemoveAllRedundantWhitespace<CR>
vnoremap \ww :retab<CR><Esc>gv:<C-w>RemoveSelectedMultipleBlankLines<CR><Esc>gv:<C-w>RemoveSelectedRedundantWhitespace<CR>

" a quicker way to spellcheck the document (do not complete the command on purpose, to be able to change language if needed)
noremap \~ :setlocal spell spelllang=en_us
noremap \\~ :setlocal nospell<CR>

" quick ways to switch between light and dark themes
nnoremap \tl :colorscheme sergebass-light<CR>
nnoremap \td :colorscheme sergebass-dark<CR>

" modify key mapping for vim-multiple-cursors plugin
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" shortcuts for language client/server use (LanguageClient plugin)
nnoremap <silent> <F12> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> \K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> \gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> \gO :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <M-\> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <M-/> :call LanguageClient#textDocument_references()<CR>

" shortcuts for language client/server use (vim-lsp plugin)
nnoremap \\K :LspHover<CR>
nnoremap \\gd :LspDefinition<CR>
nnoremap \\<F2> :LspRename<CR>
