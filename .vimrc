""" ---------------
""" GENERAL OPTIONS
""" ---------------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" double star makes :find look for files recursively
set path=.,/usr/local/include,/usr/include,,**

" even though we define our mappings in other files, we need to make sure
" that leader and local leader keys are established well before then
" use Spacemacs-style prefixes, where <Space>o and <Space>m are reserved for
" user (use them for 3rd party plugins to avoid clashes with our mappings)
let mapleader = "\<Space>o"
let maplocalleader = "\<Space>mo"

set number " enable line numbers
set scrolloff=1 " keep at least one line visible above/below cursor
set ruler " show the cursor position all the time
set rulerformat=%l:%c%V

set laststatus=2 " always display status line, even with one file being edited
set statusline=%m%r%1*\ %f\ %*%y%{fugitive#statusline()}%{ObsessionStatus()}\ %=#%n\ \"%{v:register}\ u%B/%{&fenc}/%{&ff}\ %l:%c%V\ %p%%/%L

set autoread " automatically reload files changed by external programs
au CursorHold,CursorHoldI * :checktime " check for updates each time cursor stops moving
au FocusGained,BufEnter * :checktime

set undofile " persist undo history between invocations
set undodir=~/.vim/undo " location for persistent undo history files

" do not save undo history for temporary files
augroup vimrc
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

set showcmd " display incomplete commands
set history=100 " keep this many lines of command line history

set incsearch " do incremental searching
set hlsearch " highlight search results

if has("nvim")
    set inccommand=nosplit " highlight text affected by a substitute command
endif

set mouse=a " enable mouse use in all modes

" copy to clipboard by default
set clipboard^=unnamedplus
set clipboard^=unnamed

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

" whitelist all project-specific local vimrc files
"let g:localvimrc_whitelist=['/home/sperynskyi/git/.*', '/home/sperynskyi/svn/.*', '/home/sperynskyi/repos/.*']

" apply user-defined autocompletion when pressing <Tab> (used by supertab plugin)
let g:SuperTabDefaultCompletionType = "<C-X><C-U>"
" do not autocomplete at the start of the line, after a comma or after a space:
let g:SuperTabNoCompleteAfter = ['^', ',', '\s']
set completeopt=longest,menuone
set completefunc=LanguageClient#complete
set omnifunc=

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

set colorcolumn=80,120
set cursorline
set cursorcolumn

set tags=./tags;/

" use rg (ripgrep) instead of grep, for faster searches
set grepprg=rg\ -L\ --hidden\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" consider dashes as parts of a word (for CSS, lisps, package names etc.)
set iskeyword+=-

" pressing K in normal/visual mode will look up the word/selection using this command
set keywordprg=:grep\ -ws

autocmd FileType vim setlocal keywordprg=:help
autocmd FileType sh setlocal keywordprg=:Man

" to be able to use vim's formatting commands like gq with LanguageClient
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

" LanguageClient global settings
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'haskell': ['hie', '--lsp'],
    \ 'java': ['tcp://127.0.0.1:55555'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.tsx': ['javascript-typescript-stdio'],
    \ 'typescript_': ['tsserver'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

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

    autocmd WinEnter * set colorcolumn=80,120
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

source ~/.vimrc.plugins

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

" this is useful for nested terminals, to make them use the existing nvim instance, if available
if has("nvim") && executable("nvr")
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" -------------------
" GENERAL UI SETTINGS
" -------------------

set gfn=Inconsolata\ Medium\ 10
set guioptions-=T

if $TERM == "linux"
\ || $TERM == "screen-256color"
\ || $TERM == "xterm-256color"
\ || $TERM == "rxvt-unicode-256color"
\ || $COLORTERM == "xfce4-terminal"
\ || $COLORTERM == "gnome-terminal"
\ || $COLORTERM == "Terminal"
  set t_Co=256

  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" if we're in non-tty tmux session running neovim,
" we may try using 24-bit GUI color scheme settings directly
if has("nvim") && $TMUX != "" && $TERM != "linux"
    " nvim is compiled with this feature, vim is most likely not
    " this setting may seem to conflict with the above
    " but since 24-bit colors are automatically mapped to their closest
    " 256-color counterparts, we may get away with this,
    " and this will work best in terminals with true 24-bit color support
    set termguicolors
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

" use a dark theme by default (there's a shortcut to quickly switch it, if needed)
" (one other option may be to have the "if &termguicolors" check for auto detection)
colorscheme sergebass-dark

" FIXME replace rainbow parenthese plugin with the one from
" https://github.com/luochen1990/rainbow (hopefully this works properly)
"
" chevron matching mode conflicts with XHTML highlighting so disable it for now
"au Syntax * RainbowParenthesesLoadChevrons
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

au VimEnter * RainbowParenthesesToggle

au BufReadPost *.fr set filetype=frege syntax=haskell

au BufReadPost */.xmobarrc set syntax=haskell
au BufReadPost */gitconfig set syntax=gitconfig
au BufReadPost */.vrapperrc set syntax=vim
