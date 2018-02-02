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
set statusline=%F:%l:%c\ \ %m%r%y%=\ %{fugitive#statusline()}\ %p%%/%L

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set hlsearch   " highlight search results

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

" netrw browser uses tabs to display file lists and this looks really bad
" with tab highlighting
autocmd FileType netrw set nolist

" consider dashes as parts of a word (for CSS, lisps, package names etc.)
set iskeyword+=-

" fold based on syntax, do not fold by default
set foldmethod=syntax
set foldlevel=100

" git diff -b mode (ignore whitespace changes)
set diffopt+=iwhite
set diffexpr=""

set colorcolumn=80,100
set cursorline

set tags=./tags;/

" git gutter: pass this option to git diff
let g:gitgutter_diff_args = '-w'

" use detailed listing style for netrw
let g:netrw_liststyle = 1

let g:EclimLocateFileScope = 'workspace'
let g:EclimLocateFileDefaultAction = 'edit'
let g:EclimLocateFileNonProjectScope = 'ag'
let g:EclimJavaCallHierarchyDefaultAction = 'edit'
let g:EclimJavaHierarchyDefaultAction = 'edit'

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

""" -----------------
""" KEYBOARD MAPPINGS
""" -----------------

let mapleader = "\\"
let maplocalleader = " "

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
noremap <silent> <BS> <C-w>

" buffer navigation
noremap <silent> <C-k> :bp<CR>
noremap <silent> <C-PageUp> :bp<CR>
noremap <silent> <Esc>[5;5~ :bp<CR> " C-PgUp on my terminal

noremap <silent> <C-j> :bn<CR>
noremap <silent> <C-PageDown> :bn<CR>
noremap <silent> <Esc>[6;5~ :bn<CR> " C-PgDn on my terminal

" Tab navigation
nnoremap <silent> + :tabnew<CR>
nnoremap <silent> - :tabclose<CR>
noremap <silent> <C-h> :tabp<CR>
noremap <silent> <C-l> :tabn<CR>

" Use numeric pad {+-*/} or <Ctrl+arrow> keys to resize current window (tested with rxvt-unicode-256color)
noremap <silent> <kPlus> <C-w>+
noremap <silent> <Esc>Ok <C-w>+ " Numeric + on my terminal
noremap <silent> <C-Up> <C-w>+
noremap <silent> <Esc>[1;5A <C-w>+ " C-Up on my terminal

noremap <silent> <kMinus> <C-w>-
noremap <silent> <Esc>Om <C-w>- " Numeric -
noremap <silent> <C-Down> <C-w>-
noremap <silent> <Esc>[1;5B <C-w>- " C-Down on my terminal

noremap <silent> <kDivide> <C-w><
noremap <silent> <Esc>Oo <C-w>< " Numeric / on my terminal
noremap <silent> <C-Left> <C-w><
noremap <silent> <Esc>[1;5D <C-w>< " C-Left on my terminal

noremap <silent> <kMultiply> <C-w>>
noremap <silent> <Esc>Oj <C-w>> " Numeric * on my terminal
noremap <silent> <C-Right> <C-w>>
noremap <silent> <Esc>[1;5C <C-w>> " C-Right on my terminal

" Miscellaneous useful navigation stuff
nnoremap <silent> <Leader>\ :TagbarToggle<CR>
nnoremap <silent> <Leader><BS> :CtrlPBuffer<CR>
nnoremap <silent> <Leader><Space> :CtrlPMRUFiles<CR>
nnoremap <silent> <Leader><Tab> :NERDTreeFind<CR>

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

set pastetoggle=<Leader>P

" quickly reselect just pasted text
nnoremap <silent> gV `[v`]

" map Ctrl+R to replace highlighted text (with confirmation)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" easily copy the word under cursor into the command line being edited
cnoremap <Leader><CR> <C-r>=expand("<cword>")<CR>

" search the word under cursor
nnoremap <Leader><CR> :grep -R -w <C-r>=expand("<cword>")<CR> .<Left><Left>

" quote the selected text in visual mode since that's to be used for multiple words
vnoremap <Leader><CR> <Esc>:Ag -w "<C-r>*"

" autocompletion like in most IDEs (Ctrl+Space);
" note that this does not work properly in terminals, only in gvim
inoremap <silent> <C-Space> <C-x><C-u>

" replace tabs with spaces and strip all trailing whitespace
nnoremap <Leader>ws :retab <bar> %s/\s\+$//e<CR>

" toggle git gutter line highlights
nnoremap <silent> <Leader>gd :GitGutterLineHighlightsToggle<CR>

""" --------------------------
""" General settings for eclim
""" --------------------------

nnoremap <LocalLeader><Space> :LocateFile<CR>

nnoremap <LocalLeader><BS> :Buffers<CR>

nnoremap <LocalLeader>! :ProjectProblems!<CR>
nnoremap <LocalLeader>!! :ProjectProblems<CR>

nnoremap <LocalLeader>ptd :ProjectTodo<CR>
nnoremap <LocalLeader>pr :ProjectRefreshAll<CR>
nnoremap <LocalLeader>pt :ProjectTree<CR>
nnoremap <LocalLeader>pT :ProjectsTree<CR>

nnoremap <LocalLeader>ac :Ant clean<CR>
nnoremap <LocalLeader>ab :Ant build<CR>
nnoremap <LocalLeader>at :Ant test<CR>

nnoremap <LocalLeader>v :Validate<CR>

""" --------------
""" THEME SETTINGS
""" --------------

" let g:colors_name = "sergebass"
hi Search term=reverse cterm=bold ctermfg=19 ctermbg=154 gui=bold guifg=#0000af guibg=#afff00

hi Normal term=none cterm=none ctermfg=grey ctermbg=black gui=none guifg=grey guibg=black
hi NonText term=none cterm=none ctermfg=240 gui=none guifg=#585858
hi EndOfBuffer term=none cterm=none ctermfg=240 gui=none guifg=#585858
hi Comment term=bold ctermfg=DarkCyan guifg=#80a0ff
hi Constant term=underline ctermfg=Magenta guifg=Magenta
hi Special term=bold ctermfg=DarkMagenta guifg=Red
hi Identifier term=underline cterm=bold ctermfg=Cyan guifg=#40ffff
hi Statement term=bold ctermfg=Yellow gui=bold guifg=#aa4444
hi PreProc term=underline ctermfg=LightBlue guifg=#ff80ff
hi Type term=underline ctermfg=LightGreen guifg=#60ff60 gui=bold
hi Function term=bold ctermfg=White guifg=White
hi Repeat term=underline ctermfg=White guifg=white
hi Operator ctermfg=Red guifg=Red
hi Ignore ctermfg=black guifg=bg
hi Error term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
hi ErrorMsg term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
hi WarningMsg term=reverse cterm=bold ctermfg=88 ctermbg=226 gui=bold guifg=#870000 guibg=#ffff00
hi Todo term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
hi Folded term=reverse ctermfg=yellow ctermbg=238 guifg=Yellow guibg=#303030

hi link String Constant
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi link Conditional Repeat
hi link Label Statement
hi link Keyword Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special

highlight DiffAdd cterm=none ctermfg=Yellow ctermbg=22 gui=none guifg=Yellow guibg=#004000
highlight DiffDelete cterm=none ctermfg=Yellow ctermbg=88 gui=none guifg=Yellow guibg=#400000
highlight DiffChange cterm=none ctermfg=Yellow ctermbg=18 gui=none guifg=Yellow guibg=#000040
highlight DiffText cterm=inverse ctermfg=Yellow ctermbg=18 gui=inverse guifg=Yellow guibg=#000040

highlight link GitGutterAdd DiffAdd
highlight link GitGutterDelete DiffDelete
highlight link GitGutterChange DiffChange
highlight link GitGutterChangeDelete DiffChange

highlight StatusLine cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#0000af
highlight StatusLineNC cterm=none ctermfg=249 ctermbg=237 gui=none guifg=#b2b2b2 guibg=#3a3a3a

" change statusline colors depending on the current mode
if version >= 700
  au InsertEnter * highlight StatusLine cterm=bold ctermfg=15 ctermbg=22 gui=bold guifg=#ffffff guibg=#005f00
  au InsertLeave * highlight StatusLine cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#0000af
endif

highlight TabLine term=bold cterm=bold ctermfg=white ctermbg=19
highlight TabLineFill term=bold cterm=bold ctermfg=white ctermbg=19
highlight TabLineSel term=bold cterm=bold ctermfg=yellow ctermbg=22

highlight MyWordHighlight cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
match MyWordHighlight "\<\(TODO\|FIXME\|XXX\|BUG\|ASAP\)"

" show non-space whitespace using this coloring:
highlight SpecialKey cterm=none ctermfg=201 ctermbg=236 gui=none guifg=#ff00ff guibg=#303030

" line length limit highlighting
highlight ColorColumn ctermbg=234 guibg=#202020

" make current line and its number stand out from the rest
highlight LineNr cterm=none ctermfg=240 ctermbg=0 gui=none guifg=#606060 guibg=#000000
highlight CursorLine cterm=none ctermbg=236 gui=none guibg=#303030
highlight CursorLineNR cterm=bold ctermfg=245 ctermbg=0 gui=bold guifg=#808080 guibg=#000000

augroup BgHighlight
    autocmd!

    autocmd WinEnter * set colorcolumn=80,100
    autocmd WinEnter * set cursorline

    autocmd WinLeave * set colorcolumn=0
    autocmd WinLeave * set nocursorline

augroup END

" this is our visual selection highlighting
highlight Visual ctermbg=24 guibg=#005050

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
filetype plugin indent on
syntax on

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif

filetype off
set runtimepath+=/usr/share/lilypond/2.18.2/vim/
filetype on

filetype plugin indent on

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
