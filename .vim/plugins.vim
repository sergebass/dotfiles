" our vim/neovim plugins are configured here

execute pathogen#infect()
execute pathogen#helptags()

" Make sure you use single quotes

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
if has("win32")
    call plug#begin('~/vimfiles/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" we need Vim help for vim-plug itself (e.g. :help plug-options), so register vim-plug as a plugin.
Plug 'junegunn/vim-plug'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" Plug '/usr/share/lilypond/2.18.2/vim'

" Tim Pope's vim plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-scriptease'

" Language Server Protocol support
if has("win32")
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
        \ }
else
    " Linux, FreeBSD and Mac OSX all use similar Unix path conventions and utilities
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
endif

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'

" Autocompletion plus many other things (needs vim with Python)
" Plug 'ycm-core/YouCompleteMe'

" Language-specific plugins
" Plug 'neovimhaskell/haskell-vim'
" Plug 'purescript-contrib/purescript-vim'
" Plug 'ElmCast/elm-vim'
" Plug 'idris-hackers/idris-vim'
" Plug 'derekwyatt/vim-scala'
" Plug 'lyuts/vim-rtags'
" Plug 'rust-lang/rust.vim'
" Plug 'Quramy/tsuquyomi'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'PProvost/vim-ps1'

" Various other plugins
Plug 'airblade/vim-gitgutter'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'chaoren/vim-wordmotion'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'embear/vim-localvimrc'
Plug 'ervandew/ag'
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'gcmt/wildfire.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'janko-m/vim-test'
Plug 'kien/rainbow_parentheses.vim'
Plug 'kopischke/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-grepper'
Plug 'mkitt/tabline.vim'
Plug 'romainl/vim-qf'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'severin-lemaignan/vim-minimap'
Plug 'sgur/vim-editorconfig'
Plug 'sk1418/QFGrep'
Plug 'vim-syntastic/syntastic'
Plug 'yssl/QFEnter'
Plug 'terryma/vim-multiple-cursors'

" install user-specific plugins, if configured
if filereadable(expand("~/.workspace-plugins.vim"))
    source ~/.workspace-plugins.vim
endif

" Initialize plugin system
call plug#end()