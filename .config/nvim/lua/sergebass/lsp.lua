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

-- Typescript and Javascript

vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('ts_ls')

--------------------------------------
-- Keyboard mappings for LSP functions
--------------------------------------

-- Jump to definition of the symbol under cursor
vim.keymap.set('n', '\\<CR>', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })

-- Note that <Bar> is the `|` character
vim.keymap.set('n', '\\<Bar>', vim.lsp.buf.code_action, { desc = 'LSP: Perform code action' })

-- Display information about symbol under cursor
vim.keymap.set('n', '\\K', vim.lsp.buf.hover, { desc = 'LSP: Hover over symbol' })
vim.keymap.set('n', '<Space>mhh', vim.lsp.buf.hover, { desc = 'LSP: Hover over symbol' })

-- Jump to definition of the symbol under cursor
vim.keymap.set('n', '\\gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })
vim.keymap.set('n', '<Space>mgg', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })

vim.keymap.set('n', '\\gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to declaration' })
vim.keymap.set('n', '\\gt', vim.lsp.buf.type_definition, { desc = 'LSP: Go to type definition' })
vim.keymap.set('n', '\\gi', vim.lsp.buf.implementation, { desc = 'LSP: Go to implementation' })
vim.keymap.set('n', '\\gO', vim.lsp.buf.document_symbol, { desc = 'LSP: Pick symbol in current document' })
vim.keymap.set('n', '\\go', vim.lsp.buf.workspace_symbol, { desc = 'LSP: Pick symbol in current project/workspace' })

-- Rename symbol under cursor
vim.keymap.set('n', '\\=', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })
vim.keymap.set('n', '<Space>mrr', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })

vim.keymap.set('n', '\\^', vim.lsp.buf.references, { desc = 'LSP: Find references to symbol' })

-- Find callers
vim.keymap.set('n', '<Space>mgc', vim.lsp.buf.incoming_calls, { desc = 'LSP: Find callers' })

-- Find callees
vim.keymap.set('n', '<Space>mgC', vim.lsp.buf.outgoing_calls, { desc = 'LSP: Find callees' })

vim.keymap.set('n', '\\*', vim.lsp.buf.document_highlight, { desc = 'LSP: Highlight all occurrences of symbol' })


-- vim.keymap.set('n', '\\KK', vim.lsp.buf.signature_help, { desc = 'LSP: Signature help' })

