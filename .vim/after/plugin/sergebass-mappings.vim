""" -----------------
""" KEYBOARD MAPPINGS
""" -----------------

" let 3rd party plugins use these prefixes for their default keybindings
let mapleader = '_'
let maplocalleader = '_'

" Allow saving of files as sudo if we forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" since "C-Q" is equivalent to "C-V", use <C-Q> to close all windows and quit
nnoremap <C-Q> :qa<CR>

" since "S" is equivalent to "cc", reuse it to save the current buffer
nnoremap S :w<CR>

" since "Q" is equivalent to "gQ" and is rarely used, reuse it to close the current buffer
nnoremap Q :q<CR>

" since "Y" is normally equivalent to "yy", make Y copy to the end of line:
" (this will be more consistent with C or D that also act until the end of line)
nnoremap Y y$

" since "X" is equivalent to "dh", reuse it to open last edited file (a la Vimium browser extension)
nnoremap X :call fzf#vim#history()<CR><CR>

" an alternative way to quickly save the file being edited
" (make sure to turn off terminal flow control via Ctrl+S/Q)
inoremap <silent> <C-S> <C-O>:update<CR>
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>

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

nnoremap <TAB> <C-I>
nnoremap <BS> <C-O>

nnoremap <M-TAB> g,
nnoremap <M-BS> g;

" emulate Spacemacs/SpaceVim

nnoremap <Space><Space> :
nnoremap <Space><Tab> <C-^>

" make mode-specific mappings a bit shorter, use another big button as a prefix
unmap <CR>
nmap <Space>m <CR>

nmap <F1> <Space>h

nnoremap <Space>h<Space> :h<CR>
nnoremap <Space>? :Maps<CR>
nnoremap <Space>hk :Maps<CR>
nnoremap <Space>hi :h <C-r>=expand("<cword>")<CR><CR>

nnoremap <Space>qq :qa<CR>
nnoremap <Space>qQ :qa!<CR>

nnoremap <Space>pf :GFiles<CR>
nnoremap <Space>pr :GFiles?<CR>
nnoremap <Space>pt :NERDTreeFind<CR>
nnoremap <Space>pg :Tags<CR>

nnoremap <Space>ff :Files<CR>
nnoremap <Space>fr :call fzf#vim#history()<CR>
nnoremap <Space>fs :w<CR>
nnoremap <Space>fS :wa<CR>
nnoremap <Space>fy <C-G>
nnoremap <Space>ft :NERDTreeToggle<CR>
nnoremap <Space>fed :new<CR>:e ~/.vimrc<CR>

nnoremap <Space>bb :call fzf#vim#buffers()<CR>
nnoremap <Space>bd :bd<CR>
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

" error navigation
nnoremap <Space>el :cw<CR>
nnoremap <Space>en :cnext<CR>
nnoremap <Space>ep :cprev<CR>

" code commenting
vmap <Space>; gc
nmap <Space>cl gcc

" quick shortcuts for vim-fugitive
nnoremap <Space>gs :Gstatus<CR>
nnoremap <Space>gl :Glog<CR>
nnoremap <Space>gd :Gdiff<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gg :Ggrep<Space>
nnoremap <Space>gM :Gmove<Space>

" SPC g > 	show submodule prompt
" SPC g b 	open a magit blame
" SPC g f h 	show file commits history
" SPC g H c 	clear highlights
" SPC g H h 	highlight regions by age of commits
" SPC g H t 	highlight regions by last updated time
" SPC g I 	open helm-gitignore
" SPC g s 	open a magit status window
" SPC g S 	stage current file
" SPC g m 	magit dispatch popup
" SPC g M 	display the last commit message of the current line
" SPC g t 	launch the git time machine
" SPC g U 	unstage current file

" SPC g l c 	on a commit hash, browse to the current file at this commit
" SPC g l C 	on a commit hash, create link to the file at this commit and copy it
" SPC g l l 	on a region, browse to file at current lines position
" SPC g l L 	on a region, create a link to the file highlighting the selected lines

nnoremap <Space>' :terminal<CR>

" the stock shortcut to exit terminal mode is cumbersome, let's change it
" use the same shortcut for convenience
if has('nvim') || (v:version >= 800)
    nnoremap <C-\> :terminal<CR>
    tnoremap <C-\> <C-\><C-n>
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

" Window manipulation/navigation

" A duplicate of Ctrl+W for in-browser SSH use (Ctrl+W closes browser tabs normally)
nnoremap <Space>w <C-w>

nnoremap <silent> <Space><Left> <C-w>h
nnoremap <silent> <Space><Right> <C-w>l
nnoremap <silent> <Space><Up> <C-w>k
nnoremap <silent> <Space><Down> <C-w>j

" a quick way to navigate between tabs
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

" Tab navigation
nnoremap <silent> <Space><Insert> :tabnew<CR>
nnoremap <silent> <Space><Del> :tabclose<CR>
nnoremap <silent> <Space><Home> :tabfirst<CR>
nnoremap <silent> <Space><End> :tablast<CR>
nnoremap <silent> <Space><PageUp> :tabprev<CR>
nnoremap <silent> <Space><PageDown> :tabnext<CR>

" rxvt without tmux does not support Ctrl+PgUp/Down tab navigation, so use these alternatives instead
noremap <silent> <M-PageUp> :tabprev<CR>
noremap <silent> <M-PageDown> :tabnext<CR>
noremap <silent> <M-Home> :tabmove-<CR>
noremap <silent> <M-End> :tabmove+<CR>

" Buffer management
noremap <silent> \<PageUp> :bp<CR>
noremap <silent> \<PageDown> :bn<CR>
noremap <silent> \<Home> :bfirst<CR>
noremap <silent> \<End> :blast<CR>
noremap <silent> \<Del> :bdelete<CR>
noremap <silent> \_ :ball<CR>
noremap <silent> \\| :vert ball<CR>

nnoremap <M-Del> :DeleteHiddenBuffers<CR>

" resize current window (tested with rxvt-unicode-256color)
noremap <silent> <M-/> <C-w><
noremap <silent> <kDivide> <C-w><

noremap <silent> <M-*> <C-w>>
noremap <silent> <kMultiply> <C-w>>

noremap <silent> <M-+> <C-w>+
noremap <silent> <kPlus> <C-w>+

noremap <silent> <M--> <C-w>-
noremap <silent> <kMinus> <C-w>-

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

nnoremap <silent> \<M-Tab> :Explore<CR>
nnoremap <silent> \\<M-Tab> :Lexplore<CR>

nnoremap <silent> \fr :browse oldfiles<CR>

" local tag navigation
nnoremap <silent> \<BS> :TagbarOpen fjc<CR>
nnoremap <silent> \\<BS> :TagbarToggle<CR>
nnoremap <silent> \<M-BS> :MinimapToggle<CR>

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
nnoremap \<M-Del> :ClearQuickfixList<CR>

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
nnoremap \\<M-Del> :ClearLocationList<CR>

" quickly reselect just pasted text
nnoremap <silent> gV `[v`]

" This selects the next and the previous closest text object.
map + <Plug>(wildfire-fuel)
vmap - <Plug>(wildfire-water)

" make left mouse double click perform search of a word under cursor (and shows the number of matches).
nnoremap <2-LeftMouse> *<C-O>:%s///gn<CR>``

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
nnoremap \R :%s/<C-r>=expand("<cword>")<CR>//gc<left><left><left>
" replace selected word from the current line to the end of file (with confirmation)
nnoremap \r :.,$s/<C-r>=expand("<cword>")<CR>//gc<left><left><left>

" replace highlighted text in the entire file (with confirmation)
vnoremap \R "hy:%s/<C-r>h//gc<left><left><left>
" replace highlighted text from the current line to the end of file (with confirmation)
vnoremap \r "hy:.,$s/<C-r>h//gc<left><left><left>

" by default (may be overridden in format-specific scripts),
" use ctags for jumping, with selection between multiple candidates
nnoremap <CR><CR> g<C-]>
nmap <C-LeftMouse> <CR><CR>

" quickly search the word under cursor using fzf.vim
nnoremap \<CR> :Ag<CR>:cfirst<CR>
nmap \\<CR> \<CR>

" search the word under cursor in external files
nnoremap \/ :let w=expand("<cword>")<CR><CR>:grep -s -w <C-r>=w<CR>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap \/ "*y<Esc>:grep -s "<C-r>*"<Left>

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

" An easier way to see git change history for a current line or selection
nnoremap \gh :execute 'new <bar> 0r !git log -p #'<CR>:set readonly filetype=git buftype=nofile<CR>gg
vnoremap \gh :<C-u>execute 'new <bar> 0r !git log -L <C-r>=line("'<")<CR>,<C-r>=line("'>")<CR>:#'<CR>:set readonly filetype=git buftype=nofile<CR>gg

" looking up file history in subversion
nnoremap \sh :execute 'new <bar> 0r !svn log -v --diff #'<CR>:set readonly filetype=svn buftype=nofile<CR>gg
nnoremap \sb :execute 'new <bar> 0r !svn ann -v #'<CR>:set readonly filetype=svn buftype=nofile<CR>gg

" quick ways to switch between light and dark themes
nnoremap \<F7> :colorscheme sergebass-light<CR>
nnoremap \<F8> :colorscheme sergebass-dark<CR>

" shortcuts for language client/server use
nnoremap \K :call LanguageClient#textDocument_hover()<CR>
nnoremap \gd :call LanguageClient#textDocument_definition()<CR>
nnoremap \<F5> :call LanguageClient_contextMenu()<CR>
nnoremap \<F2> :call LanguageClient#textDocument_rename()<CR>
