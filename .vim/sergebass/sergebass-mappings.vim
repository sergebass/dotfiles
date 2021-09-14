""" -----------------
""" KEYBOARD MAPPINGS
""" -----------------

" To always reset input mode to default English when leaving Insert mode with <Esc>
" inoremap <ESC> <ESC>:set iminsert=0<CR>

" Quick shortcuts to change input methods/keyboard layouts

" Latin with dead characters
nnoremap \kl :set keymap=accents<CR>
" Russian (JCUKEN)
nnoremap \kr :set keymap=russian-jcuken<CR>
" Ukrainian (JCUKEN)
nnoremap \ku :set keymap=ukrainian-jcuken<CR>

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
" nnoremap \# :mksession! Session
" nnoremap \@ :source Session

nnoremap <C-N> :Tags!<CR>
nnoremap <C-P> :GFiles!<CR>

nnoremap <BS> <C-O>

" for quicker navigation between location with changes
nnoremap <M-Tab> g,
nnoremap <M-BS> g;

" emulate Spacemacs/SpaceVim

nnoremap <Space><Space> :
nnoremap <Space><Tab> <C-^>

nnoremap <Space>h<Space> :h<CR>
nnoremap <Space>? :Maps!<CR>
nnoremap <Space>hk :Maps!<CR>
nnoremap <Space>hi :h <C-r>=expand("<cword>")<CR><CR>

nnoremap <Space>\? :Commands!<CR>

nnoremap <Space>qq :qa<CR>
nnoremap <Space>qQ :qa!<CR>

nnoremap <Space>ff :Files!<CR>
nnoremap <Space>fr :call fzf#vim#history(1)<CR>
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

nnoremap <Space>bb :call fzf#vim#buffers(1)<CR>
nnoremap <Space>bd :bdelete<CR>
nnoremap <Space>bn :bnext<CR>
nnoremap <Space>bp :bprev<CR>
nnoremap <Space>bR :e!<CR>
nnoremap <Space>bY gg"+yG
nnoremap <Space>bP ggvG"+p

" --------------
" Searching text
" --------------

" search some text in the current buffer/file (use fzf.vim)
nnoremap <Space>ss :BLines!<Space>

" search the word under cursor in current buffer/file (use fzf.vim)
nnoremap <Space>sS :let w=expand("<cword>")<CR><CR>:BLines! <C-r>=w<CR><CR>

" search some text in all currently open buffers (use fzf.vim)
nnoremap <Space>sb :Lines!<Space>

" search the word under cursor in all currently open buffers (use fzf.vim)
nnoremap <Space>sB :let w=expand("<cword>")<CR><CR>:Lines! <C-r>=w<CR><CR>

" search some text in the current project (use default tool)
nmap <Space>sp <Space>srp
nmap <Space>/ <Space>srp

" search the word under cursor in the current project (use default tool)
nmap <Space>sP <Space>srP
nmap <Space>* <Space>srP

" search some text in the current project (use fzf.vim + ripgrep)
nnoremap <Space>srp :Rg!<Space>

" search the word under cursor in the current project (use fzf.vim + ripgrep)
nnoremap <Space>srP :let w=expand("<cword>")<CR><CR>:Rg! <C-r>=w<CR><CR>

" search some text in the current project (use fzf.vim + silver searcher)
nnoremap <Space>sap :Ag!<Space>

" search the word under cursor in the current project (use fzf.vim + silver searcher)
nnoremap <Space>saP :let w=expand("<cword>")<CR><CR>:Ag! <C-r>=w<CR><CR>

" search some text in files in an arbitrary directory (current by default) using default tool
nmap <Space>sf <Space>sGf

" search word under cursor in files in an arbitrary directory (current by default) using default tool
nmap <Space>sF <Space>sGF

" search some text in files in an arbitrary directory (current by default) using rg
nnoremap <Space>srf :Rg!<CR>

" search word under cursor in files in an arbitrary directory (current by default) using rg
nnoremap <Space>srF :Rg! <C-r>=expand("<cword>")<CR><CR>

" search some text in files in an arbitrary directory (current by default) using ag
nnoremap <Space>saf :Ag!<CR>

" search word under cursor in files in an arbitrary directory (current by default) using ag
nnoremap <Space>saF :Ag! <C-r>=expand("<cword>")<CR><CR>

" search some text in files in an arbitrary directory (current by default) using grepprg
nnoremap <Space>sgf :FindText grep "" **<left><left><left><left>

" search word under cursor in files in an arbitrary directory (current by default) using grepprg
nnoremap <Space>sgF :FindText grep\ -w "<C-r>=expand("<cword>")<CR>" **<CR>

" search some text in files in an arbitrary directory (current by default) using git grep
nnoremap <Space>sGf :FindText Ggrep "" **<left><left><left><left>

" search word under cursor in files in an arbitrary directory (current by default) using git grep
nnoremap <Space>sGF :FindText Ggrep\ -w "<C-r>=expand("<cword>")<CR>" **<CR>

" search the web using DuckDuckGo
nnoremap <Space>swd :!sp-open "https://duckduckgo.com?q=<C-r>=expand("<cword>")<CR> <C-r>=&filetype<CR>"<Left>

" search the web using Google
nnoremap <Space>swg :!sp-open "https://google.com?q=<C-r>=expand("<cword>")<CR> <C-r>=&filetype<CR>"<Left>

" search the web using Wikipedia (English)
nnoremap <Space>sww :!sp-open "https://en.wikipedia.org/w/index.php?search=<C-r>=expand("<cword>")<CR> <C-r>=&filetype<CR>"<Left>

nnoremap <Space>pf :GFiles!<CR>
nnoremap <Space>pr :GFiles?<CR>
nnoremap <Space>pt :NERDTreeFind<CR>
nnoremap <Space>pg :Tags!<CR>
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

" spacemacs-compatible quick shortcuts for vim-fugitive (and more)
nnoremap <Space>gs :Git<CR>
nnoremap <Space>gl :Gclog<CR>
nnoremap <Space>gd :Gdiffsplit<CR>
nnoremap <Space>gb :Git blame<CR>
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

" jump to the next conflict start marker
nnoremap \g\  /^<<<<<<<<Space><CR>
" jump to any of the next conflict markers
nnoremap \g\| /^<<<<<<<<Space>\<bar>^<bar><bar><bar><bar><bar><bar><bar><Space>\<bar>^=======\<bar>^>>>>>>><Space><CR>

nnoremap \gL :diffget _LOCAL_<CR>
nnoremap \gR :diffget _REMOTE_<CR>
nnoremap \gB :diffget _BASE_<CR>

nnoremap \gm :GMove<Space>
nnoremap \gr :GRename<Space>
nnoremap \gx :GBrowse<CR>
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
map \1 <F1>
map \2 <F2>
map \3 <F3>
map \4 <F4>
map \5 <F5>
map \6 <F6>
map \7 <F7>
map \8 <F8>
map \9 <F9>
map \0 <F10>

" navigation mappings

" Tab navigation (using Meta/Alt key)
nnoremap <silent> <M-[> :tabprev<CR>
nnoremap <silent> <M-]> :tabnext<CR>

" a quicker way to move tabs around
nnoremap <silent> <M-{> :tabmove-<CR>
nnoremap <silent> <M-}> :tabmove+<CR>

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

" Jump to the file:line[:column] location taken from the clipboard
nnoremap \F :SPFindFile <C-r>+<CR>

" Window manipulation/navigation

" A duplicate of Ctrl+W for in-browser SSH use (Ctrl+W closes browser tabs normally)
nnoremap <Space>w <C-w>

" a quick way to close other windows _and_ tabs
nnoremap <Space>wO :only <bar> tabonly<CR>

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
nnoremap <silent> <Space><M-BS> :tabonly<CR>

" Tab navigation (using spacemacs prefix on bigger keyboards)
nnoremap <silent> <Space><Insert> :tabnew<CR>
nnoremap <silent> <Space><Del> :tabclose<CR>
nnoremap <silent> <Space><Home> :tabfirst<CR>
nnoremap <silent> <Space><End> :tablast<CR>
nnoremap <silent> <Space><PageUp> :tabprev<CR>
nnoremap <silent> <Space><PageDown> :tabnext<CR>

" allow user to choose where to move the tab (empty input causes it to move to the very end)
nnoremap <Space>\<BS> :tabmove<Space>

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
" nnoremap <silent> \<M-Tab> :NERDTreeToggle<CR>

" using netrw
nnoremap <silent> \<M-Tab> :Lexplore<CR>

nnoremap <silent> \fr :browse oldfiles<CR>
nnoremap  \lf :LocateFiles<Space>
nnoremap  \ff :FindFiles<Space>

" local tag navigation
nnoremap <silent> gO :TagbarOpen fjc<CR>

nnoremap <silent> \<BS> :TagbarOpen fjc<CR>
" nnoremap <silent> \<M-BS> :TagbarToggle<CR>
nnoremap <silent> \<M-BS> :MinimapToggle<CR>

" quickly close both quickfix and location list windows
noremap <silent> \_ :lclose<CR>:cclose<CR>

" facilitate quickfix navigation (emulate vim-unimpaired when possible)
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [<C-Q> :cpfile<CR>
nnoremap <silent> ]<C-Q> :cnfile<CR>
nnoremap <silent> [<M-Q> :colder<CR>
nnoremap <silent> ]<M-Q> :cnewer<CR>

" clear quickfix list (useful for incremental results of grepadd or vimgrepadd)
nnoremap \<Del> :ClearQuickfixList<CR>

" facilitate location list navigation (emulate vim-unimpaired when possible)
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <silent> [l :lprev<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [<C-L> :lpfile<CR>
nnoremap <silent> ]<C-L> :lnfile<CR>
nnoremap <silent> [<M-L> :lolder<CR>
nnoremap <silent> ]<M-L> :lnewer<CR>

" clear location list (useful for incremental results of lgrepadd or lvimgrepadd)
nnoremap \<M-Del> :ClearLocationList<CR>

" quickly reselect just pasted text
nnoremap <silent> gV `[v`]

" This selects the next and the previous closest text object.
map + <Plug>(wildfire-fuel)
vmap _ <Plug>(wildfire-water)

nmap <2-LeftMouse> <CR><CR>
nmap <M-LeftMouse> gF

" similar to "*" and "#" but display the number of matches without jumping to the next result
nnoremap <M-*> *<C-O>:%s///gn<CR>``
nnoremap <M-#> #<C-O>:%s///gn<CR>``

" define a custom highlighting for the word under cursor or a selection
" in the current buffer
nnoremap \# :match SPCustomHighlight "<C-r>=expand("<cword>")<CR>"
vnoremap \# "*y<Esc>:match SPCustomHighlight "<C-r>*"

" define a custom highlighting for the word under cursor or a selection
" in all open buffers
nnoremap \@ :bufdo match SPCustomHighlight "<C-r>=expand("<cword>")<CR>"
vnoremap \@ "*y<Esc>:bufdo match SPCustomHighlight "<C-r>*"

" easily copy the word under cursor into the command line being edited
nnoremap <M-CR> :<C-r>=expand("<cword>")<CR>
vnoremap <M-CR> "*y<Esc>:<C-r>*
cnoremap <M-CR> <C-r>=expand("<cword>")<CR>

" insert the current full file path into the command line or text input at the current position
cnoremap <M-/> <C-r>=expand("%:p")<CR>
inoremap <M-/> <C-r>=expand("%:p")<CR>

" insert the current file name only into the command line or text input at the current position
cnoremap <M-\> <C-r>=expand("%:t")<CR>
inoremap <M-\> <C-r>=expand("%:t")<CR>

" by default (may be overridden in format-specific scripts),
" use ctags for jumping, with selection between multiple candidates
nnoremap <CR> g<C-]>
nmap \<CR> <C-W>v<CR>
nmap -<CR> <C-W>s<CR>

nmap <C-LeftMouse> <CR>
nmap <M-LeftMouse> \<CR>
nmap <M-C-LeftMouse> -<CR>

" search the word under cursor in external files (reference search)
nnoremap \/ :let w=expand("<cword>")<CR><CR>:grep! -s -w <C-r>=w<CR>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap \/ "*y<Esc>:grep! -s "<C-r>*"<Left>

" search the word under cursor on the web
nnoremap \? :!sp-open "https://duckduckgo.com?q=<C-r>=expand("<cword>")<CR> <C-r>=&filetype<CR>"<Left>
vnoremap \? "*y<Esc>:!sp-open "https://duckduckgo.com?q=<C-r>* <C-r>=&filetype<CR>"<Left>

" search some text in all currently open buffers
nnoremap \sb :ClearQuickfixList<CR>:tabnew <bar> silent bufdo grepadd! -s -w  % <bar> only<C-Left><C-Left><C-Left><Left>

" search the word under cursor in all currently open buffers
nnoremap \sB :ClearQuickfixList<CR>:let w=expand("<cword>")<CR><CR>:tabnew <bar> silent bufdo grepadd! -s -w <C-r>=w<CR> % <bar> only<C-Left><C-Left><C-Left><Left>

" quote the selected text in visual mode since that's to be used for multiple words
vnoremap \sB "*y<Esc>:ClearQuickfixList<CR>:tabnew <bar> silent bufdo grepadd! -s "<C-r>*" % <bar> only<C-Left><C-Left><C-Left><Left><Left>

" search the FIXME markers in all currently open buffers
nnoremap \sF :ClearQuickfixList<CR>:tabnew <bar> silent bufdo grepadd! -s -w FIXME % <bar> only<C-Left><C-Left><C-Left><Left>

" shortcuts for quicker FIXME marker location
nnoremap [F ?FIXME<CR>
nnoremap ]F /FIXME<CR>

" replace selected word in the entire file (with confirmation)
nnoremap \R :%s/\<<C-r>=expand("<cword>")<CR>\>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>
" replace selected word from the current line to the end of file (with confirmation)
nnoremap \r :.,$s/\<<C-r>=expand("<cword>")<CR>\>/<C-r>=expand("<cword>")<CR>/gc<left><left><left>

" replace highlighted text in the entire file (with confirmation)
vnoremap \R "hy:%s/<C-r>h/<C-r>=expand("<cword>")<CR>/gc<left><left><left>
" replace highlighted text from the current line to the end of file (with confirmation)
vnoremap \r "hy:.,$s/<C-r>h/<C-r>=expand("<cword>")<CR>/gc<left><left><left>

" search the word under cursor in files under current directory and replace it with another text
nnoremap \% :FindAndReplaceText grep\ -w <C-r>=expand("<cword>")<CR> <C-r>=expand("<cword>")<CR> **<left><left><left>

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

" spell check the document (do not complete the command on purpose, to be able to change language if needed)
noremap <Space>Sb :setlocal spell spelllang=en_us
noremap <Space>tS :setlocal nospell<CR>

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

" NOTE that if you are using Plug mapping you should not use `noremap` mappings

" default shortcuts for language server/client use

" Neovim 0.5.0+ has built-in LSP client, use it by default
if has("nvim")

    nmap <silent> \<Bar> <Plug>(lcn-menu)

    nmap <silent> \K <cmd>lua vim.lsp.buf.hover()<CR>
    nmap <silent> \gd <cmd>lua vim.lsp.buf.definition()<CR>
    nmap <silent> \gD <cmd>lua vim.lsp.buf.declaration()<CR>
    nmap <silent> \gi <cmd>lua vim.lsp.buf.implementation()<CR>
    nmap <silent> \gO <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nmap <silent> \= <cmd>lua vim.lsp.buf.rename()<CR>
    nmap <silent> \^ <cmd>lua vim.lsp.buf.references()<CR>
    nmap <silent> \* <cmd>lua vim.lsp.buf.document_highlight()<CR>
    " nmap <silent> \+ <Plug>(lcn-explain-error)

    " jump to definition of the symbol under cursor
    nmap <silent> <Space>mgg <cmd>lua vim.lsp.buf.definition()<CR>

    " rename symbol under cursor
    nmap <silent> <Space>mrr <cmd>lua vim.lsp.buf.rename()<CR>

    " display help about symbol under cursor
    nmap <silent> <Space>mhh <cmd>lua vim.lsp.buf.hover()<CR>

else  " use 3rd-party language client(s) otherwise

    nmap <silent> \<Bar> <Plug>(lcn-menu)

    nmap <silent> \K <Plug>(lcn-hover)
    nmap <silent> \gd <Plug>(lcn-definition)
    " nmap <silent> \gD <Plug>(lcn-FIXME)
    nmap <silent> \gi <Plug>(lcn-implementation)
    nmap <silent> \gO <Plug>(lcn-symbols)
    nmap <silent> \= <Plug>(lcn-rename)
    nmap <silent> \^ <Plug>(lcn-references)
    nmap <silent> \* <Plug>(lcn-highlight)
    nmap <silent> \+ <Plug>(lcn-explain-error)

    " use LanguageClient as default filetype-specific mappings

    " jump to definition of the symbol under cursor
    nmap <silent> <Space>mgg <Plug>(lcn-definition)

    " rename symbol under cursor
    nmap <silent> <Space>mrr <Plug>(lcn-rename)

    " display help about symbol under cursor
    nmap <silent> <Space>mhh <Plug>(lcn-hover)

endif

" LSP bindings shared between neovim and vim:

" switch to another/accompanying source (e.g. source-header) file in the same window
nmap <silent> <Space>mga :call LanguageClient#textDocument_switchSourceHeader()<CR>

" switch to another/accompanying source (e.g. source-header) file in a vertical split
nmap <silent> <Space>mgA :vsplit <bar> call LanguageClient#textDocument_switchSourceHeader()<CR>
