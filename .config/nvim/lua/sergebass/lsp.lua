-- Neovim-specific built-in LSP client configuration

vim.cmd([[
  set omnifunc=v:lua.vim.lsp.omnifunc
  set tagfunc=v:lua.vim.lsp.tagfunc
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

-- Keyboard mappings for LSP functions
vim.cmd([[
  " jump to definition of the symbol under cursor
  " nmap <CR> <Cmd>lua vim.lsp.buf.definition()<CR>

  nmap \<Bar> <Cmd>lua vim.lsp.buf.code_action()<CR>

  nmap \K <Cmd>lua vim.lsp.buf.hover()<CR>
  nmap \gt <Cmd>lua vim.lsp.buf.type_definition()<CR>
  nmap \gd <Cmd>lua vim.lsp.buf.definition()<CR>
  nmap \gD <Cmd>lua vim.lsp.buf.declaration()<CR>
  nmap \gi <Cmd>lua vim.lsp.buf.implementation()<CR>
  nmap \gO <Cmd>lua vim.lsp.buf.document_symbol()<CR>
  nmap \go <Cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  nmap \= <Cmd>lua vim.lsp.buf.rename()<CR>
  nmap \^ <Cmd>lua vim.lsp.buf.references()<CR>
  nmap \* <Cmd>lua vim.lsp.buf.document_highlight()<CR>
  nmap \+ <Plug>(lcn-explain-error)

  " -----------------------
  " Spacemacs-style keymaps
  " -----------------------

  " jump to definition of the symbol under cursor
  nmap <Space>mgg <Cmd>lua vim.lsp.buf.definition()<CR>

  " rename symbol under cursor
  nmap <Space>mrr <Cmd>lua vim.lsp.buf.rename()<CR>

  " display help about symbol under cursor
  nmap <Space>mhh <Cmd>lua vim.lsp.buf.hover()<CR>

  " SPC m g &     find references (address)
  " nmap <Space>mg& <Cmd>lua vim.lsp.buf.()<CR>

  " SPC m g R     find references (read)
  " nmap <Space>mgR <Cmd>lua vim.lsp.buf.()<CR>

  " SPC m g W     find references (write)
  " nmap <Space>mgW <Cmd>lua vim.lsp.buf.()<CR>

  " SPC m g c     find callers
  nmap <Space>mgc <Cmd>lua vim.lsp.buf.incoming_calls()<CR>

  " SPC m g C     find callees
  nmap <Space>mgC <Cmd>lua vim.lsp.buf.outgoing_calls()<CR>

  " SPC m g v     vars
  " nmap <Space>mgv <Cmd>lua vim.lsp.buf.()<CR>

]])
