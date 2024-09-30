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

Plug 'prabirshrestha/async.vim'

Plug 'prabirshrestha/vim-lsp'

" register clangd C/C++/Objective C LSP server for vim-lsp plugin
" (the -background-index option is not available in clangd-7)
        " \ 'cmd': {server_info->['clangd', '-background-index']},
" FIXME clangd-15? FIXME go through multiple versions of clangd downwards?
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': expand('~/.cache/ccls') }},
      \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

" register TypeScript LSP server for vim-lsp plugin
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
endif

" register Purescript LSP server for vim-lsp plugin
if executable('purescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'purescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'purescript-language-server --stdio']},
        \ 'whitelist': ['purescript'],
        \ })
endif

" register Elm LSP server for vim-lsp plugin
if executable('elm-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'elm-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'elm-language-server --stdio']},
        \ 'whitelist': ['elm'],
        \ })
endif

" FIXME add Nix LSP support: https://mattn.github.io/vim-lsp-settings/

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
Plug 'udalov/kotlin-vim', { 'for': ['kotlin'] }
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

" git gutter: pass this option to git diff
let g:gitgutter_diff_args = '-w'

Plug 'arithran/vim-delete-hidden-buffers'
Plug 'chaoren/vim-wordmotion'

Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:100'
let g:ctrlp_extensions = [
\ 'tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
\ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir'
\ ]

Plug 'embear/vim-localvimrc'

" do not use sandboxing for local vim scripts (a bit less secure but much less bothersome either)
let g:localvimrc_sandbox=0

" trust all .lvimrc scripts under our home directory
let g:localvimrc_whitelist=[expand("~")]

Plug 'ervandew/ag'

Plug 'ervandew/supertab'

" apply omni autocompletion when pressing <Tab> (used by supertab plugin)
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" do not autocomplete at the start of the line, after a comma or after a space:
let g:SuperTabNoCompleteAfter = ['^', ',', '\s']

Plug 'flazz/vim-colorschemes'
Plug 'gcmt/wildfire.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'janko-m/vim-test'
Plug 'jceb/vim-orgmode'
Plug 'kien/rainbow_parentheses.vim'
Plug 'kopischke/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'

Plug 'majutsushi/tagbar'

let g:tagbar_width=60
let g:tagbar_show_linenumbers=1 " show absolute line numbers
let g:tagbar_map_help='<F1>' " do not use ? for help, we need it for reverse search in the window

Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-grepper'

Plug 'romainl/vim-qf'

" vim-qf: do not shorten paths in quickfix/local lists
let g:qf_shorten_path = 0

Plug 'scrooloose/nerdtree'

let g:NERDTreeMapHelp='<F1>' " do not use ? for help, we need it for reverse search in the window
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=64
let g:NERDTreeQuitOnOpen=1 " close NERDtree window after opening a file

Plug 'severin-lemaignan/vim-minimap'
Plug 'sgur/vim-editorconfig'
Plug 'sk1418/QFGrep'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-syntastic/syntastic'
Plug 'yssl/QFEnter'
Plug 'habamax/vim-do-outline'
Plug 'habamax/vim-asciidoctor'

Plug 'mzlogin/vim-markdown-toc'

" Configure markdown TOC generator (vim-markdown-toc plugin)
let g:vmt_auto_update_on_save = 0  " Do not auto-update the TOC on saving
let g:vmt_cycle_list_item_markers = 1  " Do not just use '*' for all nesting levels, cycle through the {*+-} set
let g:vmt_list_item_char = '*'  " The default bullet item character
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

Plug 'LnL7/vim-nix'

" non-github-hosted plugins
Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

" This is a new feature in vim to better integrate with gdb
packadd termdebug

" Use gdb as our debugger
let g:termdebugger = "gdb"

" FIXME configure this:
" let g:termdebug_wide = 163

if has("nvim")
    runtime plugins-nvim.vim
endif

" install user-specific plugins, if configured
if filereadable(expand("~/.workspace-plugins.vim"))
    source ~/.workspace-plugins.vim
endif

" Initialize plugin system
call plug#end()
