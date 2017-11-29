" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set mouse=a

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set hlsearch   " highlight search results

set clipboard=unnamedplus

set ruler
set autoread

set number

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set pastetoggle=<F10>

"let mapleader = " "

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Left> <C-w>h
map <C-Right> <C-w>l

map <F11> :bp<CR>
map <F12> :bn<CR>

map <Leader>0 :hide<CR>
map <Leader>1 :only<CR>
map <Leader>2 :split<CR>
map <Leader>3 :vsplit<CR>

" map Ctrl+R to replace highlighted text (with confirmation)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Eclim shortcuts

" Note: these are the default shortcuts for emacs-eclim:
" `eclim-mode' Minor Mode Bindings Starting With C-c C-e:
"
" C-c C-e a       Prefix Command
" C-c C-e b       eclim-problems
" C-c C-e d       eclim-java-doc-comment
" C-c C-e f       Prefix Command
" C-c C-e g       eclim-java-generate-getter-and-setter
" C-c C-e h       eclim-java-hierarchy
" C-c C-e i       eclim-java-import-organize
" C-c C-e m       Prefix Command
" C-c C-e n       eclim-java-new
" C-c C-e o       eclim-problems-open
" C-c C-e p       Prefix Command
" C-c C-e r       eclim-java-refactor-rename-symbol-at-point
" C-c C-e s       eclim-java-method-signature-at-point
" C-c C-e t       eclim-run-junit
" C-c C-e u       Prefix Command
" C-c C-e z       eclim-java-implement
"
" C-c C-e u r     eclim-java-run-run
"
" C-c C-e m p     eclim-maven-lifecycle-phase-run
" C-c C-e m r     eclim-maven-run
"
" C-c C-e f d     eclim-java-find-declaration
" C-c C-e f f     eclim-java-find-generic
" C-c C-e f r     eclim-java-find-references
" C-c C-e f s     eclim-java-format
" C-c C-e f t     eclim-java-find-type
"
" C-c C-e p a     eclim-debug-attach
" C-c C-e p c     eclim-project-create
" C-c C-e p g     eclim-project-goto
" C-c C-e p i     eclim-project-import
" C-c C-e p m     eclim-project-mode
" C-c C-e p p     eclim-project-mode
" C-c C-e p t     eclim-debug-test
"
" C-c C-e a a     eclim-ant-run
" C-c C-e a c     eclim-ant-clear-cache
" C-c C-e a r     eclim-ant-run
" C-c C-e a v     eclim-ant-validate

nmap <Leader>ee :Buffers<CR>
nmap <Leader>el :LocateFile<CR>

nmap <Leader>epr :ProjectRefreshAll<CR>
nmap <Leader>ept :ProjectTree<CR>
nmap <Leader>epts :ProjectsTree<CR>
nmap <Leader>eptd :ProjectTodo<CR>

nmap <Leader>eb :ProjectProblems!<CR>

nmap <Leader>ed :JavaDocComment<CR>

nmap <Leader>eh :JavaHierarchy <C-r>=expand("<cword>")<CR>

nmap <Leader>ech :JavaCallHierarchy <C-r>=expand("<cword>")<CR>
nmap <Leader>ech! :JavaCallHierarchy! <C-r>=expand("<cword>")<CR>

nmap <F3> :JavaSearchContext -a edit <C-r>=expand("<cword>")<CR><CR>
nmap <Leader><F3> :JavaSearchContext -a edit<CR>

nmap <Leader>eft :JavaSearch <C-r>=expand("<cword>")<CR>
nmap <Leader>efa :JavaSearch -a edit -s all -t all -x all -p <C-r>=expand("<cword>")<CR>
nmap <Leader>efd :JavaSearch -a edit -s all -t all -x declarations -p <C-r>=expand("<cword>")<CR>
nmap <Leader>efi :JavaSearch -a edit -s all -t all -x implementors -p <C-r>=expand("<cword>")<CR>
nmap <Leader>efr :JavaSearch -a edit -s all -t all -x references -p <C-r>=expand("<cword>")<CR>

nmap <Leader>en :JavaNew<Space>
nmap <Leader>enc :JavaConstructor
nmap <Leader>eg :JavaGet
nmap <Leader>er :JavaRename<Space>
nmap <Leader>ez :JavaImpl

nmap <Leader>es :JavaDocPreview<CR>

nmap <Leader>et :JUnit %

nmap <Leader>e1 :JavaCorrect<CR>

"nmap <Leader>ei :JavaImport<CR>
nmap <Leader>ei :JavaImportOrganize<CR>

nmap <Leader>eac :Ant clean<CR>
nmap <Leader>eab :Ant build<CR>
nmap <Leader>eat :Ant test<CR>

nmap <Leader>ev :Validate<CR>

" autocompletion like in most IDEs (Ctrl+Space);
" note that this does not work properly in terminals, only in gvim
imap <C-Space> <C-x><C-u>

set completeopt=longest,menuone

" highlight tabs and trailing spaces
set listchars=tab:>-,trail:-
set list

" remember edit position and jump to it next time the same file is edited
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif
set runtimepath+=/usr/local/go/misc/vim " replace $GOROOT with the output of: go env GOROOT

execute pathogen#infect()
filetype plugin indent on
syntax on

set tags=./tags;/

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

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

colorscheme koehler

set background=dark
highlight Normal ctermfg=grey ctermbg=black

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

highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black

highlight LineNr ctermfg=darkgrey

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
nmap <Leader>e1 :JavaCorrect

" autocompletion like in most IDEs (Ctrl+Space); note that this does not work properly in terminals
imap <C-Space> <C-x><C-u>

set completeopt=longest,menuone

" highlight tabs and trailing spaces
set listchars=tab:>-,trail:-
set list

" remember edit position and jump to it next time the same file is edited
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif
set runtimepath+=/usr/local/go/misc/vim " replace $GOROOT with the output of: go env GOROOT

execute pathogen#infect()
filetype plugin indent on
syntax on

set tags=./tags;/

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

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

colorscheme koehler

set background=dark
highlight Normal ctermfg=grey ctermbg=black

if $COLORTERM == 'xfce4-terminal' || $COLORTERM == 'gnome-terminal' || $COLORTERM == 'Terminal' || $TERM == 'screen-256color' || $TERM == 'xterm-256color'
  set t_Co=256

  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black

highlight LineNr ctermfg=darkgrey

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
nmap <Leader>e1 :JavaCorrect

" autocompletion like in most IDEs (Ctrl+Space); note that this does not work properly in terminals
imap <C-Space> <C-x><C-u>

set completeopt=longest,menuone

" highlight tabs and trailing spaces
set listchars=tab:>-,trail:-
set list

" remember edit position and jump to it next time the same file is edited
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif
set runtimepath+=/usr/local/go/misc/vim " replace $GOROOT with the output of: go env GOROOT

execute pathogen#infect()
filetype plugin indent on
syntax on

set tags=./tags;/

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

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

colorscheme koehler

set background=dark
highlight Normal ctermfg=grey ctermbg=black

if $COLORTERM == 'xfce4-terminal' || $COLORTERM == 'gnome-terminal' || $COLORTERM == 'Terminal' || $TERM == 'screen-256color' || $TERM == 'xterm-256color'
  set t_Co=256

  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black

highlight LineNr ctermfg=darkgrey

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

filetype off
set runtimepath+=/usr/share/lilypond/2.18.2/vim/
filetype on
syntax on
