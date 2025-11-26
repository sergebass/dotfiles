" Vim-specific plugins (only for Vim, not NeoVim)

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

if executable('gdb')
    " This is a new feature in vim to better integrate with gdb
    packadd termdebug

    " Use gdb as our debugger
    let g:termdebugger = "gdb"

    " FIXME configure this:
    " let g:termdebug_wide = 163

endif
