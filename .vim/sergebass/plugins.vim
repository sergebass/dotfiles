" Plugin registry for both Vim and NeoVim

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

" Use shallow clones to save storage space (we do not really need plugin git history)
let g:plug_shallow = 1

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

" A Vim plugin to copy text to the system clipboard using the ANSI OSC52 sequence.
Plug 'ojroques/vim-oscyank'

" Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.
Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:100'
let g:ctrlp_extensions = [
\ 'tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
\ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir'
\ ]

" A Vim plugin that manages your tag files
Plug 'ludovicchabant/vim-gutentags'

" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'

let g:tagbar_width=60
let g:tagbar_show_linenumbers=1 " show absolute line numbers
let g:tagbar_map_help='<F1>' " do not use ? for help, we need it for reverse search in the window

" Tim Pope's vim plugins

" capslock.vim: Software caps lock
Plug 'tpope/vim-capslock'

" characterize.vim: Unicode character metadata
Plug 'tpope/vim-characterize'

" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'

" dadbod.vim: Modern database interface for Vim
Plug 'tpope/vim-dadbod'

" dispatch.vim: Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" eunuch.vim: Helpers for UNIX
Plug 'tpope/vim-eunuch'

" fugitive.vim: A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" obsession.vim: continuously updated session files
Plug 'tpope/vim-obsession'

" repeat.vim: enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" rhubarb.vim: GitHub extension for fugitive.vim
Plug 'tpope/vim-rhubarb'

" scriptease.vim: A Vim plugin for Vim plugins
Plug 'tpope/vim-scriptease'

" :PP: Pretty print. With no argument, acts as a REPL.
" :Runtime: Reload runtime files. Like :runtime!, but it unlets any include guards first.
" :Disarm: Remove a runtime file's maps, commands, and autocommands, effectively disabling it.
" :Scriptnames: Load :scriptnames into the quickfix list.
" :Messages: Load :messages into the quickfix list, with stack trace parsing.
" :Verbose: Capture the output of a :verbose invocation into the preview window.
" :Time: Measure how long a command takes.
" :Breakadd: Like its lowercase cousin, but makes it much easier to set breakpoints inside functions. Also :Breakdel.
" :Vedit: Edit a file relative the runtime path. For example, :Vedit plugin/scriptease.vim. Also, :Vsplit, :Vtabedit, etc. Extracted from pathogen.vim.
" K: Look up the :help for the VimL construct under the cursor.
" zS: Show the active syntax highlighting groups under the cursor.
" g=: Eval a motion or selection as VimL and replace it with the result. This is handy for doing math, even outside of VimL.

" speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
Plug 'tpope/vim-speeddating'

" surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plug 'tpope/vim-surround'

" unimpaired.vim: Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" vim plugin for tmux.conf
Plug 'tmux-plugins/vim-tmux'

" A git commit browser
Plug 'junegunn/gv.vim'

" vim UI plugin for tpope/dadbod
Plug 'kristijanhusak/vim-dadbod-ui'

" Find-and-Replace (in multiple files)
" Plug 'brooth/far.vim'

Plug 'github/copilot.vim', { 'branch': 'release' }
" Use ^X+Tab instead of just Tab for Copilot suggestions
" (keep Tab for existing non-AI autocompletion)
imap <silent><script><expr> <C-X><Tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Language Server Protocol support

" normalize async job control api for vim and neovim
Plug 'prabirshrestha/async.vim'

" async language server protocol plugin for vim and neovim
Plug 'prabirshrestha/vim-lsp'

" Rust language server
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \ })
endif

" register clangd C/C++/Objective C LSP server for vim-lsp plugin
" (the -background-index option is not available in clangd-7)
        " \ 'cmd': {server_info->['clangd', '-background-index']},
" FIXME clangd-15? FIXME go through multiple versions of clangd downwards?
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'cc', 'objc', 'objcpp'],
        \ })
endif

" Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': expand('~/.cache/ccls') }},
      \ 'allowlist': ['c', 'cpp', 'cc', 'objc', 'objcpp'],
      \ })
endif

" register TypeScript LSP server for vim-lsp plugin
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'javascript'],
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

if executable('ccls')
    " Vim plugin for the ccls language server
    Plug 'm-pilia/vim-ccls'
endif

" (Repo archived) Vim bindings for rtags, llvm/clang based c++ code indexer.
" Plug 'lyuts/vim-rtags'

" Autocompletion plus many other things (needs vim with Python)
" Plug 'ycm-core/YouCompleteMe'

" ALE (Asynchronous Lint Engine)
" Plug 'dense-analysis/ale'

if executable('rustc')
    " Vim configuration for Rust.
    Plug 'rust-lang/rust.vim'
endif

" Do not auto-save buffers after running :RustFmt
let g:rustfmt_autosave = 0

if executable('gradlew')
    " Android development plugin for vim
    Plug 'hsanson/vim-android'
endif

if executable('kotlinc')
    " Kotlin plugin for Vim. Featuring: syntax highlighting, basic indentation, Syntastic support
    Plug 'udalov/kotlin-vim', { 'for': ['kotlin'] }
endif

if executable('scalac')
    " Integration of Scala into Vim
    Plug 'derekwyatt/vim-scala'
endif

if executable('nix')
    " Vim configuration files for Nix http://nixos.org/nix
    Plug 'LnL7/vim-nix'
endif

if executable('ghc') || executable('ghci')
    " Custom Haskell Vimscripts
    " Does this plugin work with traditional Vim despite the user name?
    Plug 'neovimhaskell/haskell-vim'
endif

if executable('purs')
    " Syntax highlighting and indentation for PureScript
    Plug 'purescript-contrib/purescript-vim'
endif

if executable('idris') || executable('idris2')
    " Idris mode for vim
    Plug 'idris-hackers/idris-vim'
endif

if executable('elm')
    " Elm plugin for Vim
    Plug 'ElmCast/elm-vim'
endif

if executable('tsc')
    " Yet Another TypeScript Syntax: The most advanced TypeScript Syntax Highlighting in Vim
    Plug 'HerringtonDarkholme/yats.vim'

    " A Vim plugin for TypeScript
    Plug 'Quramy/tsuquyomi'
endif

if executable('powershell.exe')
    " A Vim plugin for Windows PowerShell support
    Plug 'PProvost/vim-ps1'
endif

if executable('csc') || executable('mcs')
    " C# LSP support
    Plug 'OmniSharp/omnisharp-vim'
endif

" A Vim wrapper for running tests on different granularities.
Plug 'janko-m/vim-test'

if executable('gdb')
    " This is a new feature in vim to better integrate with gdb
    packadd termdebug
endif

" Use gdb as our debugger
let g:termdebugger = "gdb"

" FIXME configure this:
" let g:termdebug_wide = 163

" Multi-language debugger support
Plug 'puremourning/vimspector'

" Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
Plug 'ConradIrwin/vim-bracketed-paste'

" You need to be using a modern xterm-compatible terminal emulator that supports bracketed paste mode. xterm, urxvt, iTerm2, gnome-terminal (and other terminals using libvte), Putty (for Windows) are known to work.

" Then whenever you are in the insert mode and paste into your terminal emulator using command+v, shift+insert, ctrl+shift+v or middle-click, vim will automatically :set paste for you.

" Vim bookmark plugin
Plug 'MattesGroeger/vim-bookmarks'

" (Repo archived) A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'

" A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'

" git gutter: pass this option to git diff
let g:gitgutter_diff_args = '-w'

" Supplies :DeleteHiddenBuffers command
Plug 'arithran/vim-delete-hidden-buffers'

" More useful word motions for Vim
Plug 'chaoren/vim-wordmotion'

" Search local vimrc files (".lvimrc") in the tree (root dir up to current dir) and load them.
Plug 'embear/vim-localvimrc'

" do not use sandboxing for local vim scripts (a bit less secure but much less bothersome either)
let g:localvimrc_sandbox=0

" trust all .lvimrc scripts under our home directory
let g:localvimrc_whitelist=[expand("~")]

" (Repo archived) vim plugin to search using the silver searcher (ag)
Plug 'ervandew/ag'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

" apply omni autocompletion when pressing <Tab> (used by supertab plugin)
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" do not autocomplete at the start of the line, after a comma or after a space:
let g:SuperTabNoCompleteAfter = ['^', ',', '\s']

" Better Rainbow Parentheses
Plug 'kien/rainbow_parentheses.vim'

" (Repo archived) Smart selection of the closest text object
Plug 'gcmt/wildfire.vim'

" Outline asciidoc(tor) or markdown documents.
Plug 'habamax/vim-do-outline'

if executable('asciidoctor')
    " Asciidoctor plugin for Vim
    Plug 'habamax/vim-asciidoctor'
endif

" A vim 7.4+ plugin to generate table of contents for Markdown files.
Plug 'mzlogin/vim-markdown-toc'

" Configure markdown TOC generator (vim-markdown-toc plugin)
let g:vmt_auto_update_on_save = 0  " Do not auto-update the TOC on saving
let g:vmt_cycle_list_item_markers = 1  " Do not just use '*' for all nesting levels, cycle through the {*+-} set
let g:vmt_list_item_char = '*'  " The default bullet item character
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" Text outlining and task management for Vim based on Emacs' Org-Mode
Plug 'jceb/vim-orgmode'

" Make Vim handle line and column numbers in file names with a minimum of fuss
Plug 'kopischke/vim-fetch'

" The interactive scratchpad for hackers.
Plug 'metakirby5/codi.vim'

" Helps you win at grep
Plug 'mhinz/vim-grepper'

" Tame the quickfix window.
Plug 'romainl/vim-qf'

" vim-qf: do not shorten paths in quickfix/local lists
let g:qf_shorten_path = 0

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'

let g:NERDTreeMapHelp='<F1>' " do not use ? for help, we need it for reverse search in the window
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=64
let g:NERDTreeQuitOnOpen=1 " close NERDtree window after opening a file

" A Sublime-like minimap for VIM, based on the Drawille console-based drawing library
Plug 'severin-lemaignan/vim-minimap'

" (Repo archived) Yet another EditorConfig (http://editorconfig.org) plugin for vim written in vimscript only
Plug 'sgur/vim-editorconfig'

" A vim plugin to filter entries in Quickfix
Plug 'sk1418/QFGrep'

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

" (Repo archived) Syntax checking hacks for vim
" ALE is suggested as the "spiritual successor"
" Plug 'vim-syntastic/syntastic'

" Open a Quickfix item in a window you choose. (Vim plugin)
Plug 'yssl/QFEnter'

" Emoji abbreviations in Vim
Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

" A plugin to colorize color names and codes
Plug 'chrisbra/Colorizer'

" one colorscheme pack to rule them all!
Plug 'flazz/vim-colorschemes'

" All 256 xterm colors with their RGB equivalents, right in Vim!
" Provides :XtermColorTable command.
Plug 'guns/xterm-color-table.vim'

if has("nvim")
    runtime sergebass/plugins-nvim.vim
endif

" Install user-specific plugins, if configured
if filereadable(expand("~/.workspace-plugins.vim"))
    source ~/.workspace-plugins.vim
endif

" Initialize plugin system
call plug#end()
