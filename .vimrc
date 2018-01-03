""" ---------------
""" GENERAL OPTIONS
""" ---------------

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

set autoread

set number " enable line numbers

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set completeopt=longest,menuone

" highlight tabs and trailing spaces
set listchars=tab:>.,trail:.
set list

set colorcolumn=80,100
set cursorline

set tags=./tags;/

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

" use Space key as an additional leader prefix
map <Space> <Leader>

" A duplicate of Ctrl+W for in-browser SSH use (Ctrl+W closes tabs normally)
map <Leader>w <C-w>

map <C-Down> <C-w>j
map <C-Up> <C-w>k
map <C-Left> <C-w>h
map <C-Right> <C-w>l

map <C-k> :bp<CR>
map <C-j> :bn<CR>

map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

noremap <Leader>t :tabnew<CR>

" these shortcuts are intended to resemble Emacs ones
noremap <Leader>0 :hide<CR>
noremap <Leader>1 :only<CR>
noremap <Leader>2 :split<CR>
noremap <Leader>3 :vsplit<CR>

set pastetoggle=<Leader>P

" quickly reselect just pasted text
nmap gV `[v`]

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

nmap <Leader>eh :JavaHierarchy <C-r>=expand("<cword>")<CR><CR>

nmap <Leader>ech :JavaCallHierarchy <C-r>=expand("<cword>")<CR><CR>
nmap <Leader>ech! :JavaCallHierarchy! <C-r>=expand("<cword>")<CR><CR>

nmap <F3> :JavaSearchContext -a edit<CR>
nmap <Leader>\ :JavaSearchContext -a edit<CR>
nmap <Leader>eff :JavaSearchContext -a edit<CR>

nmap <Leader>eft :JavaSearch -a edit <C-r>=expand("<cword>")<CR><CR>
nmap <Leader>efa :JavaSearch -a edit -s all -t all -x all -p <C-r>=expand("<cword>")<CR><CR>
nmap <Leader>efd :JavaSearch -a edit -s all -t all -x declarations -p <C-r>=expand("<cword>")<CR><CR>
nmap <Leader>efi :JavaSearch -a edit -s all -t all -x implementors -p <C-r>=expand("<cword>")<CR><CR>
nmap <Leader>efr :JavaSearch -a edit -s all -t all -x references -p <C-r>=expand("<cword>")<CR><CR>

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
hi Error term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow

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

highlight DiffAdd cterm=none ctermfg=fg ctermbg=Green gui=none guifg=fg guibg=Green
highlight DiffDelete cterm=none ctermfg=fg ctermbg=Red gui=none guifg=fg guibg=Red
highlight DiffChange cterm=none ctermfg=fg ctermbg=Blue gui=none guifg=fg guibg=Blue
highlight DiffText cterm=none ctermfg=bg ctermbg=White gui=none guifg=bg guibg=White

highlight ColorColumn ctermbg=17 guibg=#000020
highlight LineNr ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212
highlight SpecialKey cterm=none ctermfg=yellow ctermbg=52 guifg=yellow guibg=darkred

highlight StatusLine cterm=bold ctermfg=15 ctermbg=19 gui=bold guifg=#ffffff guibg=#4e4e4e
highlight StatusLineNC cterm=none ctermfg=249 ctermbg=237 gui=none guifg=#b2b2b2 guibg=#3a3a3a

highlight TabLine term=bold cterm=bold ctermfg=white ctermbg=19
highlight TabLineFill term=bold cterm=bold ctermfg=white ctermbg=19
highlight TabLineSel term=bold cterm=bold ctermfg=yellow ctermbg=22

highlight MyWordHighlight cterm=bold ctermfg=88 ctermbg=226
match MyWordHighlight "\<\(TODO\|FIXME\|XXX\|BUG\|ASAP\)"

augroup BgHighlight
    autocmd!

    autocmd WinEnter * set colorcolumn=80,100
    autocmd WinEnter * set cursorline
    autocmd WinEnter * hi LineNr ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212

    autocmd WinLeave * set colorcolumn=0
    autocmd WinLeave * set nocursorline
    autocmd WinLeave * hi LineNr ctermfg=274 guifg=#e9e9e9 ctermbg=133 guibg=#212121

augroup END

" highlight current line number
hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

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
