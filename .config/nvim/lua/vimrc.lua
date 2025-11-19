-- vimrc.lua: NeoVim configuration in Lua

require'scrollbar'.setup()
require'nu'.setup{}

-- Neovim-specific built-in LSP client configuration

-- Set default root markers for all clients
vim.lsp.config('*', {
  root_markers = { '.git' },
})

-- Rust

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      cargo = { targetDir = true },
      check = { command = 'clippy' },
      inlayHints = {
        bindingModeHints = { enabled = true },
        closureCaptureHints = { enabled = true },
        closureReturnTypeHints = { enable = 'always' },
        maxLength = 100,
      },
      rustc = { source = 'discover' },
    }
  },
})

-- C and C++

vim.lsp.config("ccls", {
    filetypes = { 'c', 'h', 'i', 'cc', 'hh', 'ii', 'cpp', 'hpp', 'inl', 'cxx', 'hxx' },
    -- root_markers = { '.git' },
    init_options = {
        -- compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        -- clang = {
        --   excludeArgs = { "-frounding-math"} ;
        -- };
    }
})

vim.lsp.enable('ccls')

vim.lsp.config("clangd", {
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--enable-config'},
    filetypes = { 'c', 'h', 'i', 'cc', 'hh', 'ii', 'cpp', 'hpp', 'inl', 'cxx', 'hxx' },
    -- root_markers = { '.git' },
    init_options = {
        -- fallback_flags = { '-std=c++23', '-I/usr/include/c++/12' },
        fallback_flags = { '-std=c++23' },
        -- compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        -- clang = {
        --   excludeArgs = { "-frounding-math"} ;
        -- };
    }
})

vim.lsp.enable('clangd')

-- Typescript and Javascript

vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('ts_ls')
