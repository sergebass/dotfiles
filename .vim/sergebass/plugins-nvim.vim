" NeoVim-specific plugins

"  Quickstart configs for Nvim LSP
Plug 'neovim/nvim-lspconfig'

set omnifunc=v:lua.vim.lsp.omnifunc
set tagfunc=v:lua.vim.lsp.tagfunc

" Nvim Treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

" Emacs org-mode support
Plug 'nvim-orgmode/orgmode'

" Extensible Neovim Scrollbar
Plug 'petertriho/nvim-scrollbar'

" Support Debug Adapter Protocol plugins
Plug 'mfussenegger/nvim-dap'

" support of native debuggers (gdb, lldb, pdb etc.)
" Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

" NuShell support: "All the lua functions I don't want to write twice."
Plug 'nvim-lua/plenary.nvim'

" null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
Plug 'nvimtools/none-ls.nvim'

if executable('nu')
    " Basic editor support for the nushell language
    Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
endif

" FIXME keep?
" Language Server Protocol (LSP) support for vim and neovim.
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
