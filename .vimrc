""" ---------------
""" GENERAL OPTIONS
""" ---------------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" double star makes :find look for files recursively
set path=.,/usr/local/include,/usr/include,,**

set mouse=a

" always display status line, even with one file being edited
set laststatus=2
set statusline=%F:%l:%c\ \ %m%r%y%{ObsessionStatus()}%=\ %{fugitive#statusline()}\ %p%%/%L

set scrolloff=1 " keep at least one line visible above/below cursor
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set hlsearch " highlight search results

if has("nvim")
    set inccommand=nosplit " highlight text affected by a substitute command
endif

set clipboard^=unnamedplus

set autoread

set number " enable line numbers

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set completeopt=longest,menuone

" command mode autocompletion
set wildmode=list:longest,full
set wildmenu

" highlight tabs and trailing spaces
set listchars=tab:>.,trail:.
set list

" use a Unicode U2551 character (double vertical bar) for vertical split separator
set fillchars+=vert:║

" netrw browser uses tabs to display file lists and this looks really bad
" with tab highlighting
autocmd FileType netrw set nolist

" fold based on syntax, do not fold by default
set foldmethod=syntax
set foldlevel=100

" git diff -b mode (ignore whitespace changes)
set diffopt+=iwhite
set diffexpr=""

set colorcolumn=80,100
set cursorline
set cursorcolumn

set tags=./tags;/

" use ag (SilverSearcher) instead of grep, for faster searches
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" consider dashes as parts of a word (for CSS, lisps, package names etc.)
set iskeyword+=-

" pressing K in normal/visual mode will look up the word/selection using this command
set keywordprg=:grep\ -ws

autocmd FileType vim setlocal keywordprg=:help
autocmd FileType sh setlocal keywordprg=:Man
autocmd FileType haskell setlocal keywordprg=hoogle

" git gutter: pass this option to git diff
let g:gitgutter_diff_args = '-w'

" use detailed listing style for netrw
let g:netrw_liststyle = 1

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:100'
let g:ctrlp_extensions = [
\ 'tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
\ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir'
\ ]

set gfn=Inconsolata\ Medium\ 11
set guioptions-=T

if $COLORTERM == 'xfce4-terminal'
\ || $COLORTERM == 'gnome-terminal'
\ || $COLORTERM == 'Terminal'
\ || $TERM == 'screen-256color'
\ || $TERM == 'xterm-256color'
\ || $TERM == 'rxvt-unicode-256color'
  set t_Co=256

  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" make sure tmux correctly passes DECSCUSR cursor shape change sequences
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

" FIXME Uncomment when it's clear how to make this work with urxvt...
" if &term =~ '^xterm\\|rxvt'
"   " use an orange cursor in insert mode
"   let &t_SI = "\<Esc>]12;orange\x7"
"   " use a red cursor otherwise
"   let &t_EI = "\<Esc>]12;red\x7"
"   silent !echo -ne "\033]12;red\007"
"   " reset cursor when vim exits
"   autocmd VimLeave * silent !echo -ne "\033]112\007"
"   " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
"
"   " solid underscore
"   let &t_SI .= "\<Esc>[4 q"
"   " solid block
"   let &t_EI .= "\<Esc>[2 q"
"   " 1 or 0 -> blinking block
"   " 3 -> blinking underscore
"   " Recent versions of xterm (282 or above) also support
"   " 5 -> blinking vertical bar
"   " 6 -> solid vertical bar
" endif

""" ----------------
""" CUSTOM FUNCTIONS
""" ----------------
function ClearQuickfixList()
  call setqflist([])
endfunction

command! ClearQuickfixList call ClearQuickfixList()

function ClearLocationList()
  call setloclist(0, [])
endfunction

command! ClearLocationList call ClearLocationList()

command RemoveMultipleBlankLines %s/^\_s\+\n/\r/e
command RemoveRedundantWhitespace %s/\s\+$//e

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

" Miscellaneous useful navigation stuff
nnoremap <silent> <BS><Tab> :Explore<CR>
nnoremap <silent> <BS><S-Tab> :Vexplore<CR>

nnoremap <silent> <BS><BS> :CtrlPMRUFiles<CR>
nnoremap <silent> <BS>f :CtrlP<CR>
nnoremap <silent> <BS>b :CtrlPBuffer<CR>
nnoremap <silent> <BS>t :CtrlPTag<CR>
nnoremap <silent> <BS>m :CtrlPBookmark<CR>
nnoremap <silent> <BS>c :CtrlPChange<CR>
nnoremap <silent> <BS>x :CtrlPMixed<CR>

nnoremap <silent> <Leader><Tab> :NERDTreeToggle<CR>
nnoremap <silent> <Leader><S-Tab> :NERDTreeFind<CR>

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

set pastetoggle=<Leader>P

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

augroup BgHighlight
    autocmd!

    autocmd WinEnter * set colorcolumn=80,100
    autocmd WinEnter * set cursorline
    autocmd WinEnter * set cursorcolumn

    autocmd WinLeave * set colorcolumn=0
    autocmd WinLeave * set nocursorline
    autocmd WinLeave * set nocursorcolumn

augroup END

""" -------------------------------
""" MISCELLANEOUS STUFF AND PLUGINS
""" -------------------------------

" remember edit position and jump to it next time the same file is edited
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if exists("syntax_on")
  syntax reset
endif

execute pathogen#infect()
execute pathogen#helptags()

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif

filetype off
" FIXME hardcoded path, fix ASAP!
set runtimepath+=/usr/share/lilypond/2.18.2/vim/
filetype on

" automatically pick correct templates based on the specified file name extension
augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r ~/templates/vim-template.'.expand("<afile>:e")
augroup END

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

" color settings for the rainbow parentheses plugin
let g:rbpt_colorpairs = [
    \ ['green',  'green'],
    \ ['red',    'red'],
    \ ['cyan',   'cyan'],
    \ ['yellow', 'yellow'],
    \ ['blue',   'blue'],
    \ ]

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

source ~/.vim/colors.vim
source ~/.vim/eclim.vim

filetype plugin indent on
syntax on
