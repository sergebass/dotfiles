" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

colorscheme koehler
"colorscheme elflord
"colorscheme darkblue " dark
"colorscheme cool " dark
"colorscheme summerfruit256 " light
"colorscheme slate " dark
"colorscheme norwaytoday " dark
"colorscheme made_of_code " dark
"colorscheme inkpot " dark
"colorscheme symfony " dark
"colorscheme tesla " dark
"colorscheme transparent " dark
"colorscheme wombat256 " dark

set background=dark
highlight Normal ctermfg=grey ctermbg=black

if $COLORTERM == 'gnome-terminal' || $COLORTERM == 'Terminal' || $TERM == 'screen-256color' || $TERM == 'xterm-256color'
" if &term =~ '256color'
  set t_Co=256

  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" set clipboard=unnamed
set clipboard=unnamedplus

set ruler
set autoread

set number
highlight LineNr ctermfg=darkgrey

set expandtab
"set smarttab
set tabstop=4
set shiftwidth=4

set autoindent
"set smartindent
"set cindent

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set pastetoggle=<F10>

nmap <Space> i
map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Left> <C-w>h
map <C-Right> <C-w>l

" remember edit position and jump to it next time the same file is edited
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set mouse=a
set hlsearch

" Clear filetype flags before changing runtimepath to force Vim to reload
" them.
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif
set runtimepath+=/usr/local/go/misc/vim " replace $GOROOT with the output of: go env GOROOT
filetype plugin indent on
syntax on

set tags=./tags;/

au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))

" " set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
" 
" " let Vundle manage Vundle, required
" Plugin 'gmarik/Vundle.vim'
" 
" Plugin 'fatih/vim-go'
" Plugin 'vim-jp/vim-go-extra'
" Bundle 'derekwyatt/vim-scala'

" All of your Plugins must be added before the following line
" call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
"

set gfn=Inconsolata\ Medium\ 11
set guioptions-=T

"set foldmethod=syntax

"source /home/sergii/src/vim-fswitch/plugin/fswitch.vim

highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black

highlight DiffAdd cterm=none ctermfg=fg ctermbg=Green gui=none guifg=fg guibg=Green
highlight DiffDelete cterm=none ctermfg=fg ctermbg=Red gui=none guifg=fg guibg=Red
highlight DiffChange cterm=none ctermfg=fg ctermbg=Blue gui=none guifg=fg guibg=Blue
highlight DiffText cterm=none ctermfg=bg ctermbg=White gui=none guifg=bg guibg=White

" highlight current line number
hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

" map Ctrl+R to replace highlighted text (with confirmation)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
