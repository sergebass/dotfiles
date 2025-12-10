-- Coding-related plugins and configurations for Neovim

return {
    -- Quickstart configs for Nvim LSP
    {
      'neovim/nvim-lspconfig',
      config = function()
        -- LSP (Language Server Protocol) support and other coding features
        require('sergebass.lsp')
      end
    },

    -- Nvim Treesitter configurations and abstraction layer
    -- FIXME: reconfigure:
    -- { 'nvim-treesitter/nvim-treesitter', { build = 'TSUpdate'}},
    { 'nvim-treesitter/nvim-treesitter' },

    -- Asynchronous linter
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                -- Example: use 'vale' for markdown files
                markdown = { 'vale' },
            }
        end
    },

    -- Support Debug Adapter Protocol plugins
    {
        'mfussenegger/nvim-dap',
        config = function()
            require('sergebass.dap')
        end
    },

    -- GitHub Copilot
    {
        'github/copilot.vim',
        -- { branch = 'release' },
        config = function()
            vim.cmd([[
                " Use ^X+Tab instead of just Tab for Copilot suggestions
                " (keep Tab for existing non-AI autocompletion)
                imap <silent><script><expr> <C-X><Tab> copilot#Accept("\<CR>")
                let g:copilot_no_tab_map = v:true
            ]])
        end
    },

    -- Clangd's off-spec features for neovim's LSP client.
    -- Use https://sr.ht/~p00f/clangd_extensions.nvim instead.
    {
      'p00f/clangd_extensions.nvim',
      config = function()
        require('clangd_extensions').setup()

        -- Use \` to switch between header and source files in C and C++
        vim.keymap.set('n', '\\`', function()
          vim.cmd.ClangdSwitchSourceHeader()
        end, { desc = 'Clangd: header-source file toggle' })

        -- Use Space+mga to switch between header and source files in C and C++ (spacemacs style)
        vim.keymap.set('n', '<Space>mga', function()
          vim.cmd.ClangdSwitchSourceHeader()
        end, { desc = 'Clangd: header-source file toggle' })
      end
    },

    -- dadbod.vim: Modern database interface for Vim
    { 'tpope/vim-dadbod' },

    -- vim UI plugin for tpope/dadbod
    { 'kristijanhusak/vim-dadbod-ui' },

    -- FIXME: if executable('rustc') ?
    -- Vim configuration for Rust.
    {
        'rust-lang/rust.vim',
        ft = { 'rust' },
        config = function()
            vim.cmd([[
                " Disable automatic formatting on save using rustfmt (:RustFmt)
                let g:rustfmt_autosave = 0
            ]])
        end,
    },

    -- FIXME: if executable('nix') 
    -- Nix language support (http://nixos.org/nix)
    { 'LnL7/vim-nix' },

  -- FIXME: if executable('nu')
  -- Basic editor support for the nushell language
  -- {
  --   'LhKipp/nvim-nu',
  --   ft = { 'nu' },
  --   build = ':TSInstall nu',
  --   config = function()
  --     require('nu').setup()
  --   end,
  -- },

    -- " NuShell support: "All the lua functions I don't want to write twice."
    -- Plug 'nvim-lua/plenary.nvim'

    -- " null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    -- Plug 'nvimtools/none-ls.nvim'

    -- " Autocompletion plus many other things (needs vim with Python)
    -- " Plug 'ycm-core/YouCompleteMe'

    -- " ALE (Asynchronous Lint Engine)
    -- " Plug 'dense-analysis/ale'

    -- if executable('gradlew')
    --     " Android development plugin for vim
    --     Plug 'hsanson/vim-android'
    -- endif

    -- if executable('kotlinc')
    --     " Kotlin plugin for Vim. Featuring: syntax highlighting, basic indentation, Syntastic support
    --     Plug 'udalov/kotlin-vim', { 'for': ['kotlin'] }
    -- endif

    -- if executable('scalac')
    --     " Integration of Scala into Vim
    --     Plug 'derekwyatt/vim-scala'
    -- endif

    -- if executable('ghc') || executable('ghci')
    --     Plug 'neovimhaskell/haskell-vim'
    -- endif

    -- if executable('purs')
    --     " Syntax highlighting and indentation for PureScript
    --     Plug 'purescript-contrib/purescript-vim'
    -- endif

    -- if executable('idris') || executable('idris2')
    --     " Idris mode for vim
    --     Plug 'idris-hackers/idris-vim'
    -- endif

    -- if executable('elm')
    --     " Elm plugin for Vim
    --     Plug 'ElmCast/elm-vim'
    -- endif

    -- if executable('tsc')
    --     " Yet Another TypeScript Syntax: The most advanced TypeScript Syntax Highlighting in Vim
    --     Plug 'HerringtonDarkholme/yats.vim'

    --     " A Vim plugin for TypeScript
    --     Plug 'Quramy/tsuquyomi'
    -- endif

    -- if executable('powershell.exe')
    --     " A Vim plugin for Windows PowerShell support
    --     Plug 'PProvost/vim-ps1'
    -- endif

    -- if executable('csc') || executable('mcs')
    --     " C# LSP support
    --     Plug 'OmniSharp/omnisharp-vim'
    -- endif

    -- " A Vim wrapper for running tests on different granularities.
    -- Plug 'janko-m/vim-test'

    -- " FIXME keep?
    -- " Language Server Protocol (LSP) support for vim and neovim.
    -- " if has("win32")
    -- "     Plug 'autozimu/LanguageClient-neovim', {
    -- "         \ 'branch': 'next',
    -- "         \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
    -- "         \ }
    -- " else
    -- "     " Linux, FreeBSD and Mac OSX all use similar Unix path conventions and utilities
    -- "     Plug 'autozimu/LanguageClient-neovim', {
    -- "         \ 'branch': 'next',
    -- "         \ 'do': 'bash install.sh',
    -- "         \ }
    -- " endif
    -- " set completefunc=LanguageClient#complete
    -- "
    -- " to be able to use vim's formatting commands like gq with LanguageClient
    -- "set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

    -- "" LanguageClient global settings

    -- "" Automatically start language servers.
    -- "" FIXME was 1
    -- "let g:LanguageClient_autoStart = 0

    -- "" let g:LanguageClient_loggingFile = expand('~/.vim/LanguageClient.log')
    -- "" let g:LanguageClient_loadSettings = 1

    -- "" Use an absolute configuration path if you want system-wide settings
    -- "" (.vim/settings.json is used by default)
    -- "" let g:LanguageClient_settingsPath = expand('~/.config/nvim/settings.json')

    -- "" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
    -- ""let g:LanguageClient_hasSnippetSupport = 0

    -- "let g:LanguageClient_diagnosticsList = "Location"

    -- "" Install Rust language server using a command like:
    -- "" $ rustup component add rls --toolchain stable-x86_64-unknown-linux-gnu
    -- "" (adjust toolchain accordingly)

    -- "" Use these lines to use ccls as a language server for the C family of languages:
    -- "    " \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    -- "    " \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    -- "    " \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    -- "    " \ 'objcpp': ['ccls', '--log-file=/tmp/cc.log'],

    -- "let g:LanguageClient_serverCommands = {
    -- "    \ 'haskell': ['hie', '--lsp'],
    -- "    \ 'purescript': ['purescript-language-server', '--stdio'],
    -- "    \ 'elm': ['elm-language-server', '--stdio'],
    -- "    \ 'typescript': ['typescript-language-server', '--stdio'],
    -- "    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    -- "    \ 'javascript': ['typescript-language-server', '--stdio'],
    -- "    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    -- "    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    -- "    \ 'c': ['clangd'],
    -- "    \ 'cpp': ['clangd'],
    -- "    \ 'objc': ['clangd'],
    -- "    \ 'objcpp': ['clangd'],
    -- "    \ 'java': ['tcp://127.0.0.1:55555'],
    -- "    \ }
}
