-- Neovim-specific built-in LSP client configuration

vim.cmd([[
  set omnifunc=v:lua.vim.lsp.omnifunc
  set tagfunc=v:lua.vim.lsp.tagfunc
  set formatexpr=v:lua.vim.lsp.formatexpr
]])

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

vim.lsp.enable('rust_analyzer')

-- C and C++

vim.lsp.config("clangd", {
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--enable-config'},
    filetypes = { 'c', 'h', 'i', 'cc', 'hh', 'ii', 'cpp', 'hpp', 'inl', 'cxx', 'hxx' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
    init_options = {
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

-- Do not enable ccls right away to avoid clashes with clangd (this results in symbol duplication etc.)
-- vim.lsp.enable('ccls')

-- Assembly language
vim.lsp.config('asm_lsp', {
    cmd = { 'asm-lsp' },
    filetypes = { 'asm', 's', 'S' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('asm_lsp')

-- TODO: LLVM IR

-- CMake
vim.lsp.config('cmake', {
    cmd = { 'cmake-language-server' },
    filetypes = { 'cmake' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('cmake')

-- Python

vim.lsp.config('pylsp', {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('pylsp')

-- TODO: Kotlin

-- TODO: Java

-- TODO: SQL/PostgreSQL/SQLite

-- TODO: Dockerfile

-- TODO: YAML

-- TODO: TOML

-- TODO: XML

-- Typescript and Javascript

vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('ts_ls')

-- bash shell

vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'sh', 'bash' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('bashls')

-- TODO: fish shell

-- TODO: nushell

-- TODO: Windows powershell/bat

-- Markdown, MDX (Markdown with JSX), AsciiDoc, RST, HTML text/prose linting

vim.lsp.config('vale', {
    -- TODO: scan for executable to use
    cmd = { 'vale-ls' }, -- Note: this can also be vale.vale-ls depending on installation method (e.g. Ubuntu snap)
    filetypes = { 'text', 'markdown', 'mdx', 'asciidoc', 'rst', 'html', 'gitcommit' },
    root_markers = { '.git', '.vale.ini' },
})

vim.lsp.enable('vale')

-- Nix language (NixOS configuration and Nixpkgs package definitions)

vim.lsp.config('nixd', {
    cmd = { 'nixd' },
    filetypes = { 'nix' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('nixd')

-- TODO: Haskell

-- TODO: PureScript

-- Vimscript language server
vim.lsp.config('vimls', {
    cmd = { 'vim-language-server', '--stdio' },
    filetypes = { 'vim', 'vimdoc' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('vimls')

-- Lua language server (for Neovim configuration files)
vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.enable('lua_ls')

--------------------------------------
-- Keyboard mappings for LSP functions
--------------------------------------

local pickers = require('telescope.builtin')

-- Jump to definition of the symbol under cursor
vim.keymap.set('n', '\\<CR>', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })

-- Note that <Bar> is the `|` character
vim.keymap.set('n', '\\<Bar>', vim.lsp.buf.code_action, { desc = 'LSP: Perform code action' })

-- Display information about symbol under cursor
vim.keymap.set('n', '\\K', vim.lsp.buf.hover, { desc = 'LSP: Hover over symbol' })
vim.keymap.set('n', '<Space>mhh', vim.lsp.buf.hover, { desc = 'LSP: Hover over symbol' })

-- Jump to definition of the symbol under cursor
vim.keymap.set('n', '\\gd', pickers.lsp_definitions, { desc = 'LSP: Go to definition (telescope)' })
vim.keymap.set('n', '<Space>mgg', pickers.lsp_definitions, { desc = 'LSP: Go to definition (telescope)' })

vim.keymap.set('n', '\\gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to declaration' })
vim.keymap.set('n', '\\gt', pickers.lsp_type_definitions, { desc = 'LSP: Go to type definition (telescope)' })
vim.keymap.set('n', '\\gi', pickers.lsp_implementations, { desc = 'LSP: Go to implementation (telescope)' })
vim.keymap.set('n', '\\gO', pickers.lsp_document_symbols, { desc = 'LSP: Pick symbol in current document (telescope)' })
vim.keymap.set('n', '\\go', pickers.lsp_workspace_symbols, { desc = 'LSP: Pick symbol in current project/workspace (telescope)' })

-- Rename symbol under cursor
vim.keymap.set('n', '\\=', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })
vim.keymap.set('n', '<Space>mrr', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })

vim.keymap.set('n', '\\^', pickers.lsp_references, { desc = 'LSP: Find references to symbol' })

-- Find callers
vim.keymap.set('n', '<Space>mgc', pickers.lsp_incoming_calls, { desc = 'LSP: Find callers' })

-- Find callees
vim.keymap.set('n', '<Space>mgC', pickers.lsp_outgoing_calls, { desc = 'LSP: Find callees' })

vim.keymap.set('n', '\\*', vim.lsp.buf.document_highlight, { desc = 'LSP: Highlight all occurrences of symbol' })

-- Diagnostics
vim.keymap.set('n', '\\!', function()
  pickers.diagnostics({ bufnr = 0 })  -- Only for current buffer
end, { desc = 'LSP: Diagnostics for buffer' })
vim.keymap.set('n', '\\$', pickers.diagnostics, { desc = 'LSP: Diagnostics for project/workspace' })

-- vim.keymap.set('n', '\\KK', vim.lsp.buf.signature_help, { desc = 'LSP: Signature help' })

