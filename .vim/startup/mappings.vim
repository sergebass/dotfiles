""" -----------------
""" KEYBOARD MAPPINGS
""" -----------------

let mapleader = "\\"
let maplocalleader = "\\\\"

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

" A duplicate of Ctrl+W for in-browser SSH use (Ctrl+W closes tabs normally)
noremap <Space> <C-w>

" for some reason, pressing <Space> twice doesn't have the same effect as ^W^W
noremap <Space><Space> <C-w><C-w>

" Buffer navigation
map <silent> <BS>[ :bp<CR>
map <silent> <BS>] :bn<CR>
map <silent> <BS>, :bfirst<CR>
map <silent> <BS>. :blast<CR>
map <silent> <BS>- :ball<CR>
map <silent> <BS>\| :vert ball<CR>

" Tab navigation
map <silent> <BS><Insert> :tabnew<CR>
map <silent> <BS><Del> :tabclose<CR>
map <silent> <BS><Home> :tabfirst<CR>
map <silent> <BS><End> :tablast<CR>
map <silent> <BS><PageUp> :tabprev<CR>
map <silent> <BS><PageDown> :tabnext<CR>

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

" an alternative way to quickly save the file being edited
" (make sure to turn terminal flow control via Ctrl+S/Q)
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" restore the session kept in the Session.vim in current directory
nnoremap <Leader>@ :source Session.vim<CR>

" Miscellaneous useful navigation stuff
nnoremap <silent> <BS><CR> :browse oldfiles<CR>

nnoremap <silent> <BS><Tab> :Explore<CR>
nnoremap <silent> <BS><S-Tab> :Lexplore<CR>

nnoremap <silent> <BS><BS> :CtrlPMRUFiles<CR>
nnoremap <silent> <BS>f :CtrlP<CR>
nnoremap <silent> <BS>b :CtrlPBuffer<CR>
nnoremap <silent> <BS>t :CtrlPTag<CR>
nnoremap <silent> <BS>m :CtrlPBookmark<CR>
nnoremap <silent> <BS>c :CtrlPChange<CR>
nnoremap <silent> <BS>x :CtrlPMixed<CR>

nnoremap <silent> <Leader><Tab> :NERDTreeFind<CR>
nnoremap <silent> <Leader><S-Tab> :NERDTreeToggle<CR>

nnoremap <silent> <C-\> :TagbarToggle<CR>

" close both quickfix and location list windows
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
nnoremap <Leader>\| :ClearQuickfixList<CR>

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
nnoremap <LocalLeader>\| :ClearLocationList<CR>

" This selects the next closest text object.
map + <Plug>(wildfire-fuel)

" This selects the previous closest text object.
vmap - <Plug>(wildfire-water)

" make left mouse double click perform search of a word under cursor
nnoremap <2-LeftMouse> *

" quickly reselect just pasted text
nnoremap <silent> gV `[v`]

" map Ctrl+R to replace highlighted text (with confirmation)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" easily copy the word under cursor into the command line being edited
nnoremap <Leader><CR> <Esc>:<C-r>=expand("<cword>")<CR><Home>
vnoremap <Leader><CR> "*y<Esc>:<C-r>*<Home>
cnoremap <Leader><CR> <C-r>=expand("<cword>")<CR>

" search the word under cursor in external files
nnoremap <Leader>/ :let w=expand("<cword>")<CR><CR>:grep -s -w <C-r>=w<CR>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap <Leader>/ "*y<Esc>:grep -s "<C-r>*"<Left>

" search the word under cursor in all open buffers
nnoremap <Leader><BS> :ClearQuickfixList<CR>:let w=expand("<cword>")<CR><CR>:silent bufdo grepadd! -s -w <C-r>=w<CR> %<Left><Left>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap <Leader><BS> "*y<Esc>:ClearQuickfixList<CR>:silent bufdo grepadd! -s "<C-r>*" %<Left><Left><Left>

" search the word under cursor on the web
nnoremap <Leader>? :!xdg-open "https://duckduckgo.com?q=<C-r>=expand("<cword>")<CR> <C-r>=&filetype<CR>"<Left>
vnoremap <Leader>? "*y<Esc>:!xdg-open "https://duckduckgo.com?q=<C-r>* <C-r>=&filetype<CR>"<Left>

" autocompletion like in most IDEs (Ctrl+Space);
" note that this does not work properly in terminals, only in gvim
inoremap <silent> <C-Space> <C-x><C-u>

" replace tabs with spaces and strip all redundant/trailing whitespace
nnoremap <Leader>ws :retab<CR>:RemoveMultipleBlankLines<CR>:RemoveRedundantWhitespace<CR>

" quick shortcuts for vim-fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gg :Ggrep<Space>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gs :Gstatus<CR>