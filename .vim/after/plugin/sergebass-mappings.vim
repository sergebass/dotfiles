""" -----------------
""" KEYBOARD MAPPINGS
""" -----------------

" emulate Spacemacs/SpaceVim
let mapleader = "\<Space>"
let maplocalleader = "\\\\"
map <Space><Space> <Leader><Leader>
noremap <Leader><Leader> <Esc>:

" use <Leader> with numeric keys to simulate finctional keys,
" for use on terminals/machines where Fn keys are missing (e.g. Chromebook)
noremap <silent> <Leader>1 <F1>
noremap <silent> <Leader>2 <F2>
noremap <silent> <Leader>3 <F3>
noremap <silent> <Leader>4 <F4>
noremap <silent> <Leader>5 <F5>
noremap <silent> <Leader>6 <F6>
noremap <silent> <Leader>7 <F7>
noremap <silent> <Leader>8 <F8>
noremap <silent> <Leader>9 <F9>
noremap <silent> <Leader>0 <F10>
noremap <silent> <Leader>10 <F10>
noremap <silent> <Leader>11 <F11>
noremap <silent> <Leader>12 <F12>
noremap <silent> <Leader>13 <F13>
noremap <silent> <Leader>14 <F14>
noremap <silent> <Leader>15 <F15>
noremap <silent> <Leader>16 <F16>
noremap <silent> <Leader>17 <F17>
noremap <silent> <Leader>18 <F18>
noremap <silent> <Leader>19 <F19>

" the stock shortcut to exit terminal mode is cumbersome, let's change it
if has('nvim')
    " use the same shortcut for convenience
    nnoremap <M-BS> :terminal<CR>
    tnoremap <M-BS> <C-\><C-n>
endif

" navigation mappings

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

" Use these mappings to avoid reaching for arrow keys
" (or if terminal does not register Shift+{Left/Right} keys properly)
map <silent> <C-h> <S-Left>
map <silent> <C-l> <S-Right>

" Make jumping to the next method/function faster (for languages with Java/C++ style curly braces)
nnoremap <silent> <C-j> ]m
nnoremap <silent> <C-k> [m

" A duplicate of Ctrl+W for in-browser SSH use (Ctrl+W closes browser tabs normally)
noremap <Leader>w <C-w>

" Tab navigation
noremap <silent> <Space><Insert> :tabnew<CR>
noremap <silent> <Space><Del> :tabclose<CR>
noremap <silent> <Space><Home> :tabfirst<CR>
noremap <silent> <Space><End> :tablast<CR>
noremap <silent> <Space><PageUp> :tabprev<CR>
noremap <silent> <Space><PageDown> :tabnext<CR>
noremap <Space><BS> :tabmove<Space>
noremap <silent> <C-S-Home> :tabmove 0<CR>
noremap <silent> <C-S-End> :tabmove<CR>
noremap <silent> <C-S-PageUp> :tabmove-<CR>
noremap <silent> <C-S-PageDown> :tabmove+<CR>

" rxvt without tmux does not support Ctrl+PgUp/Down tab navigation, so use these alternatives instead
noremap <silent> <M-PageUp> :tabprev<CR>
noremap <silent> <M-PageDown> :tabnext<CR>

" Buffer management
noremap <silent> <Leader><PageUp> :bp<CR>
noremap <silent> <Leader><PageDown> :bn<CR>
noremap <silent> <Leader><Home> :bfirst<CR>
noremap <silent> <Leader><End> :blast<CR>
noremap <silent> <Leader><Del> :bdelete<CR>
noremap <silent> <Leader>_ :ball<CR>
noremap <silent> <Leader>\| :vert ball<CR>

" Alternative shortcuts for traversing buffers
noremap <silent> <M-Tab> :bn<CR>
noremap <silent> <M-S-Tab> :bp<CR>

" Use numeric pad {+-*/} or <Ctrl+arrow> keys to resize current window (tested with rxvt-unicode-256color)
noremap <silent> <kPlus> <C-w>+
" Numeric + on my terminal
noremap <silent> <Esc>Ok <C-w>+
noremap <silent> <C-Up> <C-w>+
" C-Up on my terminal
noremap <silent> <Esc>[1;5A <C-w>+

noremap <silent> <kMinus> <C-w>-
" Numeric -
noremap <silent> <Esc>Om <C-w>-
noremap <silent> <C-Down> <C-w>-
" C-Down on my terminal
noremap <silent> <Esc>[1;5B <C-w>-

noremap <silent> <kDivide> <C-w><
" Numeric / on my terminal
noremap <silent> <Esc>Oo <C-w><
noremap <silent> <C-Left> <C-w><
" C-Left on my terminal
noremap <silent> <Esc>[1;5D <C-w><

noremap <silent> <kMultiply> <C-w>>
" Numeric * on my terminal
noremap <silent> <Esc>Oj <C-w>>
noremap <silent> <C-Right> <C-w>>
" C-Right on my terminal
noremap <silent> <Esc>[1;5C <C-w>>

" an alternative way to quickly save the file being edited
" (make sure to turn off terminal flow control via Ctrl+S/Q)
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" session management accelerators (don't forget to add .vim extension!)
nnoremap <Leader># :mksession! Session
nnoremap <Leader>@ :source Session

" Miscellaneous useful search/navigation stuff

" using FZF
nnoremap <silent> <BS><Space> :call fzf#vim#buffers()<CR>
nnoremap <silent> <BS><BS> :call fzf#vim#history()<CR>
nnoremap <silent> <BS>R :Rg<CR>
nnoremap <silent> <BS>A :Ag<CR>
nnoremap <silent> <BS>f :Files<CR>
nnoremap <silent> <BS>F :Filetypes<CR>
nnoremap <silent> <BS>\ :GFiles<CR>
nnoremap <silent> <BS>\| :GFiles?<CR>
nnoremap <silent> <BS>/ :BLines<CR>
nnoremap <silent> <BS>? :Lines<CR>
nnoremap <silent> <BS>t :BTags<CR>
nnoremap <silent> <BS>T :Tags<CR>
nnoremap <silent> <BS>g :BCommits<CR>
nnoremap <silent> <BS>G :Commits<CR>
nnoremap <silent> <BS>w :Windows<CR>
nnoremap <silent> <BS>m :Marks<CR>
nnoremap <silent> <BS>k :Maps<CR>
nnoremap <silent> <BS>c :Commands<CR>

" using CtrlP
nnoremap <silent> <BS><C-R> :CtrlPMRUFiles<CR>
nnoremap <silent> <BS><C-F> :CtrlP<CR>
nnoremap <silent> <BS><C-B> :CtrlPBuffer<CR>
nnoremap <silent> <BS><C-T> :CtrlPTag<CR>
nnoremap <silent> <BS><C-M> :CtrlPBookmark<CR>
nnoremap <silent> <BS><C-H> :CtrlPChange<CR>
nnoremap <silent> <BS><C-X> :CtrlPMixed<CR>

" using NERDTree
nnoremap <silent> <BS><Tab> :NERDTreeFind<CR>
nnoremap <silent> <BS><S-Tab> :NERDTreeToggle<CR>

nnoremap <silent> <Leader><Tab> :Explore<CR>
nnoremap <silent> <Leader><S-Tab> :Lexplore<CR>

nnoremap <silent> <S-Tab> :browse oldfiles<CR>

nnoremap <silent> <C-_> :TagbarToggle<CR>
nnoremap <silent> <Leader><C-_> :MinimapToggle<CR>

nnoremap <silent> gO :TagbarOpen fjc<CR>

" quickly close both quickfix and location list windows
noremap <silent> _ :lclose<CR>:cclose<CR>

" facilitate quickfix navigation
nnoremap <silent> <Leader>[ :cprev<CR>
nnoremap <silent> <Leader>] :cnext<CR>
nnoremap <silent> <Leader>{ :cpfile<CR>
nnoremap <silent> <Leader>} :cnfile<CR>
nnoremap <silent> <Leader>( :colder<CR>
nnoremap <silent> <Leader>) :cnewer<CR>
nnoremap <silent> <Leader>, :cfirst<CR>
nnoremap <silent> <Leader>. :clast<CR>
nnoremap <silent> <Leader>- :cclose<CR>
nnoremap <silent> <Leader>+ :copen<CR>
nnoremap <Leader>= :cw<CR>

" clear quickfix list (useful for incremental results of grepadd or vimgrepadd)
nnoremap <Leader><S-Del> :ClearQuickfixList<CR>

" facilitate location list navigation
nnoremap <silent> <LocalLeader>[ :lprev<CR>
nnoremap <silent> <LocalLeader>] :lnext<CR>
nnoremap <silent> <LocalLeader>{ :lpfile<CR>
nnoremap <silent> <LocalLeader>} :lnfile<CR>
nnoremap <silent> <LocalLeader>( :lolder<CR>
nnoremap <silent> <LocalLeader>) :lnewer<CR>
nnoremap <silent> <LocalLeader>, :lfirst<CR>
nnoremap <silent> <LocalLeader>. :llast<CR>
nnoremap <silent> <LocalLeader>- :lclose<CR>
nnoremap <silent> <LocalLeader>+ :lopen<CR>
nnoremap <LocalLeader>= :lw<CR>

" clear location list (useful for incremental results of lgrepadd or lvimgrepadd)
nnoremap <LocalLeader><S-Del> :ClearLocationList<CR>

nnoremap <BS><Del> :DeleteHiddenBuffers<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" map Ctrl+R to replace highlighted text (with confirmation)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" quickly reselect just pasted text
nnoremap <silent> gV `[v`]

" This selects the next and the previous closest text object.
map + <Plug>(wildfire-fuel)
vmap - <Plug>(wildfire-water)

" make left mouse double click perform search of a word under cursor
nnoremap <2-LeftMouse> *

" define a custom highlighting for the word under cursor or a selection
" in all open buffers
nnoremap <Leader>* :bufdo match SPCustomHighlight "<C-r>=expand("<cword>")<CR>"
vnoremap <Leader>* "*y<Esc>:bufdo match SPCustomHighlight "<C-r>*"

" define a custom highlighting for the word under cursor or a selection
" in the current buffer
nnoremap <LocalLeader>* :match SPCustomHighlight "<C-r>=expand("<cword>")<CR>"
vnoremap <LocalLeader>* "*y<Esc>:match SPCustomHighlight "<C-r>*"

" easily copy the word under cursor into the command line being edited
nnoremap <C-\> :<C-r>=expand("<cword>")<CR><Home>
vnoremap <C-\> "*y<Esc>:<C-r>*<Home>
cnoremap <C-\> <C-r>=expand("<cword>")<CR>

" in case Alt+Enter is recognized correctly, make it an equivalent of Ctrl+Backslash
map <M-CR> <C-\>

" by default (may be overridden in format-specific scripts),
" use ctags for jumping, with selection between multiple candidates
nnoremap <CR> g<C-]>
nnoremap <C-LeftMouse> g<C-]>

" quickly search the word under cursor using fzf.vim
nnoremap <Leader><BS> :Ag<CR>:cfirst<CR>

" speed up the search by auto-comitting the grep commands
map <Leader><CR> <Leader>/<CR>
map <LocalLeader><CR> <LocalLeader>/<CR>

" search the word under cursor in external files
nnoremap <Leader>/ :let w=expand("<cword>")<CR><CR>:grep -s -w <C-r>=w<CR>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap <Leader>/ "*y<Esc>:grep -s "<C-r>*"<Left>

" search the word under cursor on the web
nnoremap <Leader>? :!xdg-open "https://duckduckgo.com?q=<C-r>=expand("<cword>")<CR> <C-r>=&filetype<CR>"<Left>
vnoremap <Leader>? "*y<Esc>:!xdg-open "https://duckduckgo.com?q=<C-r>* <C-r>=&filetype<CR>"<Left>

" search the word under cursor in all open buffers
" FIXME fix this, does not work in terminal
nnoremap <Leader><C-Space> :ClearQuickfixList<CR>:let w=expand("<cword>")<CR><CR>:silent bufdo grepadd! -s -w <C-r>=w<CR> %<Left><Left>
" quote the selected text in visual mode since that's to be used for multiple words
" FIXME fix this, does not work in terminal
vnoremap <Leader><C-Space> "*y<Esc>:ClearQuickfixList<CR>:silent bufdo grepadd! -s "<C-r>*" %<Left><Left><Left>

" autocompletion like in most IDEs (Ctrl+Space);
" note that this does not work properly in terminals, only in gvim
" FIXME fix this, does not work in terminal
inoremap <silent> <C-Space> <C-x><C-u>

" whitespace cleanup: replace tabs with spaces, remove redundant lines, strip all redundant/trailing whitespace
noremap <Leader>WT :retab<CR>

nnoremap <Leader>WS :RemoveAllRedundantWhitespace<CR>
vnoremap <Leader>WS :<C-w>RemoveSelectedRedundantWhitespace<CR>

nnoremap <Leader>WL :RemoveAllMultipleBlankLines<CR>
vnoremap <Leader>WL :<C-w>RemoveSelectedMultipleBlankLines<CR>

nnoremap <Leader>WW :retab<CR>:RemoveAllMultipleBlankLines<CR>:RemoveAllRedundantWhitespace<CR>
vnoremap <Leader>WW :retab<CR><Esc>gv:<C-w>RemoveSelectedMultipleBlankLines<CR><Esc>gv:<C-w>RemoveSelectedRedundantWhitespace<CR>

" An easier way to see git change history for a current line or selection
nnoremap <Leader>gh :execute 'new <bar> 0r !git log -p #'<CR>:set readonly filetype=git buftype=nofile<CR>gg
vnoremap <Leader>gh :<C-u>execute 'new <bar> 0r !git log -L <C-r>=line("'<")<CR>,<C-r>=line("'>")<CR>:#'<CR>:set readonly filetype=git buftype=nofile<CR>gg

" quick shortcuts for vim-fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gg :Ggrep<Space>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gs :Gstatus<CR>

" looking up file history in subversion
nnoremap <Leader>sh :execute 'new <bar> 0r !svn log -v --diff #'<CR>:set readonly filetype=svn buftype=nofile<CR>gg
nnoremap <Leader>sb :execute 'new <bar> 0r !svn ann -v #'<CR>:set readonly filetype=svn buftype=nofile<CR>gg

" quick ways to switch between light and dark themes
nnoremap <Leader><F7> :colorscheme sergebass-light<CR>
nnoremap <Leader><F8> :colorscheme sergebass-dark<CR>

nnoremap <Leader>R :set readonly<CR>
nnoremap <Leader>W :set noreadonly<CR>

" shortcuts for language client/server use
nnoremap <Leader><F5> :call LanguageClient_contextMenu()<CR>
nnoremap <Leader>K :call LanguageClient#textDocument_hover()<CR>
nnoremap <Leader>gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader><F2> :call LanguageClient#textDocument_rename()<CR>
