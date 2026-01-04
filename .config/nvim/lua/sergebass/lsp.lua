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

-- Typescript and Javascript

vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    -- root_markers = { '.git' },
})

vim.lsp.enable('ts_ls')

-- Markdown, MDX (Markdown with JSX), AsciiDoc, RST, HTML text/prose linting

vim.lsp.config('vale', {
    cmd = { 'vale-ls' },
    filetypes = { 'text', 'markdown', 'mdx', 'asciidoc', 'rst', 'html', 'gitcommit' },
    root_markers = { '.git', '.vale.ini' },
})

vim.lsp.enable('vale')

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

