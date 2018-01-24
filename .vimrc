""" ---------------
""" GENERAL OPTIONS
""" ---------------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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

""" -----------------
""" KEYBOARD MAPPINGS
""" -----------------

let mapleader = "\\"
let maplocalleader = " "

" A duplicate of Ctrl+W for in-browser SSH use (Ctrl+W closes tabs normally)
noremap <silent> <Leader>w <C-w>

noremap <silent> <C-Down> <C-w>j
noremap <silent> <C-Up> <C-w>k
noremap <silent> <C-Left> <C-w>h
noremap <silent> <C-Right> <C-w>l

noremap <silent> <C-k> :bp<CR>
noremap <silent> <C-j> :bn<CR>

noremap <silent> <C-h> :tabp<CR>
noremap <silent> <C-l> :tabn<CR>

noremap <silent> <Leader>t :tabnew<CR>

" these shortcuts are intended to resemble Emacs ones
noremap <silent> <Leader>0 :hide<CR>
noremap <silent> <Leader>1 :only<CR>
noremap <silent> <Leader>2 :split<CR>
noremap <silent> <Leader>3 :vsplit<CR>

" facilitate quickfix navigation
nnoremap <silent> <Leader>[ :cprev<CR>
nnoremap <silent> <Leader>] :cnext<CR>

" make <Leader><CR> in quickfix windows open files in new tabs
autocmd FileType qf nnoremap <silent> <buffer> <Leader><CR> <C-w><CR><C-w>T

" facilitate location list navigation
nnoremap <silent> <Leader>{ :lprev<CR>
nnoremap <silent> <Leader>} :lnext<CR>

set pastetoggle=<Leader>P

" quickly reselect just pasted text
nnoremap <silent> gV `[v`]

" map Ctrl+R to replace highlighted text (with confirmation)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" show a window with the file outline (ctags-based, install tagbar plugin first)
nnoremap <silent> <Leader><BS> :TagbarToggle<CR>

" show most recently used file selector
nnoremap <silent> <Leader>\ :CtrlPMRUFiles<CR>

" easily copy the word under cursor into the command line being edited
cnoremap <Leader><CR> <C-r>=expand("<cword>")<CR>

" search the word under cursor using ag
nnoremap <Leader><CR> :Ag -w <C-r>=expand("<cword>")<CR>
" quote the selected text in visual mode since that's to be used for multiple words
vnoremap <Leader><CR> <Esc>:Ag -w "<C-r>*"

nnoremap <silent> <Leader><Tab> :NERDTreeFind<CR>

" autocompletion like in most IDEs (Ctrl+Space);
" note that this does not work properly in terminals, only in gvim
inoremap <silent> <C-Space> <C-x><C-u>

" replace tabs with spaces and strip all trailing whitespace
nnoremap <Leader>ws :retab <bar> %s/\s\+$//e<CR>

" toggle git gutter line highlights
nnoremap <silent> <Leader>gd :GitGutterLineHighlightsToggle<CR>

""" -------------------------------------------------------
""" MODE-SPECIFIC CONFIGURATION: ECLIM supported file types
""" -------------------------------------------------------

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

nnoremap <LocalLeader><Space> :LocateFile<CR>

nnoremap <LocalLeader>e :Buffers<CR>

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

""" ---------------------------------
""" MODE-SPECIFIC CONFIGURATION: JAVA
""" ---------------------------------

autocmd FileType java nnoremap <buffer> <LocalLeader>^ :JavaHierarchy<CR>

autocmd FileType java nnoremap <buffer> <LocalLeader>< :JavaCallHierarchy<CR>
autocmd FileType java nnoremap <buffer> <LocalLeader>> :JavaCallHierarchy!<CR>

autocmd FileType java nnoremap <buffer> <LocalLeader><CR> :JavaSearchContext -a edit<CR>

autocmd FileType java nnoremap <buffer> <LocalLeader>ff :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x all -s all -t all
autocmd FileType java nnoremap <buffer> <LocalLeader>fd :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x declarations -s all -t all
autocmd FileType java nnoremap <buffer> <LocalLeader>fi :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x implementors -s all -t all
autocmd FileType java nnoremap <buffer> <LocalLeader>fr :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x references -s all -t all

autocmd FileType java nnoremap <buffer> <LocalLeader>? :JavaDocPreview<CR>

autocmd FileType java nnoremap <buffer> <LocalLeader>d :JavaDocComment<CR>

autocmd FileType java nnoremap <buffer> <LocalLeader>n :JavaNew<Space>
autocmd FileType java nnoremap <buffer> <LocalLeader>nc :JavaConstructor
autocmd FileType java nnoremap <buffer> <LocalLeader>g :JavaGet
autocmd FileType java nnoremap <buffer> <LocalLeader>r :JavaRename<Space>
autocmd FileType java nnoremap <buffer> <LocalLeader>z :JavaImpl

autocmd FileType java nnoremap <buffer> <LocalLeader>t :JUnit %

autocmd FileType java nnoremap <buffer> <LocalLeader>1 :JavaCorrect<CR>

autocmd FileType java nnoremap <buffer> <LocalLeader>i :JavaImportOrganize<CR>

""" --------------
""" THEME SETTINGS
""" --------------

" let g:colors_name = "sergebass"

"highlight Normal term=none cterm=none ctermfg=White ctermbg=Black gui=none guifg=White guibg=Black
hi Normal ctermfg=grey ctermbg=black guifg=cyan guibg=black
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
hi Error term=reverse ctermbg=red ctermfg=black guibg=red guifg=black
hi WarningMsg term=reverse ctermbg=yellow ctermfg=black guibg=yellow guifg=black
hi Todo term=standout ctermbg=yellow ctermfg=blue guifg=blue guibg=yellow
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

highlight MyWordHighlight cterm=bold ctermfg=88 ctermbg=226
match MyWordHighlight "\<\(TODO\|FIXME\|XXX\|BUG\|ASAP\)"

" show non-space whitespace using this coloring:
highlight SpecialKey cterm=none ctermfg=yellow ctermbg=52 gui=none guifg=yellow guibg=darkred

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

au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

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

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons
