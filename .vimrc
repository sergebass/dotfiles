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

" git gutter: pass this option to git diff
let g:gitgutter_diff_args = '-w'

" use detailed listing style for netrw
let g:netrw_liststyle = 1

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:100'
let g:ctrlp_extensions = [
\ 'tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
\ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir'
\ ]

set pastetoggle=<Leader>P

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

" automatically pick correct templates based on the specified file name extension
augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r ~/templates/vim-template.'.expand("<afile>:e")
augroup END

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

filetype plugin indent on
syntax on

source ~/.vim/startup/functions.vim
source ~/.vim/startup/commands.vim

" -------------------
" GENERAL UI SETTINGS
" -------------------

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

" FIXME this seems to only work with gvim, not nvim-qt
if has('gui_running')
    set background=light
    set termguicolors
else
    set background=dark
endif

colorscheme sergebass

" FIXME replace rainbow parenthese plugin with the one from
" https://github.com/luochen1990/rainbow (hopefully this works properly)
"
" chevron matching mode conflicts with XHTML highlighting so disable it for now
"au Syntax * RainbowParenthesesLoadChevrons
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

au VimEnter * RainbowParenthesesToggle
