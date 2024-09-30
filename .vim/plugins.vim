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
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'tmux-plugins/vim-tmux'

" vim UI plugin for tpope/dadbod
Plug 'kristijanhusak/vim-dadbod-ui'

" Find-and-Replace (in multiple files)
" Plug 'brooth/far.vim'

" Language Server Protocol support

if has("nvim")
    " Built-in LSP client support in neovim (version 0.5.0 and later)
    Plug 'neovim/nvim-lspconfig'

    " FIXME keep?
    " if has("win32")
    "     Plug 'autozimu/LanguageClient-neovim', {
    "         \ 'branch': 'next',
    "         \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
    "         \ }
    " else
    "     " Linux, FreeBSD and Mac OSX all use similar Unix path conventions and utilities
    "     Plug 'autozimu/LanguageClient-neovim', {
    "         \ 'branch': 'next',
    "         \ 'do': 'bash install.sh',
    "         \ }
    " endif
    " set completefunc=LanguageClient#complete
    "
    " to be able to use vim's formatting commands like gq with LanguageClient
    "set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

    "" LanguageClient global settings

    "" Automatically start language servers.
    "" FIXME was 1
    "let g:LanguageClient_autoStart = 0

    "" let g:LanguageClient_loggingFile = expand('~/.vim/LanguageClient.log')
    "" let g:LanguageClient_loadSettings = 1

    "" Use an absolute configuration path if you want system-wide settings
    "" (.vim/settings.json is used by default)
    "" let g:LanguageClient_settingsPath = expand('~/.config/nvim/settings.json')

    "" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
    ""let g:LanguageClient_hasSnippetSupport = 0

    "let g:LanguageClient_diagnosticsList = "Location"

    "" Install Rust language server using a command like:
    "" $ rustup component add rls --toolchain stable-x86_64-unknown-linux-gnu
    "" (adjust toolchain accordingly)

    "" Use these lines to use ccls as a language server for the C family of languages:
    "    " \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    "    " \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    "    " \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    "    " \ 'objcpp': ['ccls', '--log-file=/tmp/cc.log'],

    "let g:LanguageClient_serverCommands = {
    "    \ 'haskell': ['hie', '--lsp'],
    "    \ 'purescript': ['purescript-language-server', '--stdio'],
    "    \ 'elm': ['elm-language-server', '--stdio'],
    "    \ 'typescript': ['typescript-language-server', '--stdio'],
    "    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    "    \ 'javascript': ['typescript-language-server', '--stdio'],
    "    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    "    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    "    \ 'c': ['clangd'],
    "    \ 'cpp': ['clangd'],
    "    \ 'objc': ['clangd'],
    "    \ 'objcpp': ['clangd'],
    "    \ 'java': ['tcp://127.0.0.1:55555'],
    "    \ }

endif

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
Plug 'm-pilia/vim-ccls'

" Autocompletion plus many other things (needs vim with Python)
" Plug 'ycm-core/YouCompleteMe'

" ALE (Asynchronous Lint Engine)
" FIXME note that the user was renamed from w0rp
" Plug 'dense-analysis/ale'

" Language-specific plugins
" FIXME Multiple file types
" Plug 'FIXME', { 'for': ['clojure', 'scheme'] }
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'
Plug 'hsanson/vim-android'
" Plug 'ElmCast/elm-vim'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'PProvost/vim-ps1'
" Plug 'Quramy/tsuquyomi'
" Plug 'derekwyatt/vim-scala'
" Plug 'idris-hackers/idris-vim'
" Plug 'lyuts/vim-rtags'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'purescript-contrib/purescript-vim'

" Multi-language debugger support
Plug 'puremourning/vimspector'

" Various other plugins
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'chaoren/vim-wordmotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'embear/vim-localvimrc'
Plug 'ervandew/ag'
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'gcmt/wildfire.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'janko-m/vim-test'
Plug 'jceb/vim-orgmode'
Plug 'kien/rainbow_parentheses.vim'
Plug 'kopischke/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-grepper'
Plug 'romainl/vim-qf'
Plug 'scrooloose/nerdtree'
Plug 'severin-lemaignan/vim-minimap'
Plug 'sgur/vim-editorconfig'
Plug 'sk1418/QFGrep'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-syntastic/syntastic'
Plug 'yssl/QFEnter'
Plug 'habamax/vim-do-outline'
Plug 'habamax/vim-asciidoctor'
Plug 'mzlogin/vim-markdown-toc'
Plug 'LnL7/vim-nix'

"Other NeoVim-specific plugins
if has("nvim")
    Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

    " org-mode support
    Plug 'nvim-orgmode/orgmode'

    Plug 'petertriho/nvim-scrollbar'

    " Support Debug Adapter Protocol plugins
    Plug 'mfussenegger/nvim-dap'

    " support of native debuggers (gdb, lldb, pdb etc.)
    " Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

    " FIXME Multiple file types
    " Plug 'FIXME', { 'for': ['clojure', 'scheme'] }

    " FIXME nushell support plugins
    Plug 'nvim-lua/plenary.nvim'
    " Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'nvimtools/none-ls.nvim'
    Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
endif

" non-github-hosted plugins
Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

" install user-specific plugins, if configured
if filereadable(expand("~/.workspace-plugins.vim"))
    source ~/.workspace-plugins.vim
endif

" Initialize plugin system
call plug#end()
