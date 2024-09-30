require'scrollbar'.setup()
require'nu'.setup{}

-- Neovim-specific built-in LSP client configuration
lspconfig = require'lspconfig'

-- rls (Rust)
lspconfig.rls.setup{}

-- FIXME uncomment when working
-- ccls (C++)
lspconfig.ccls.setup{}

-- FIXME implement project-specific configuration: (different C++ language standards etc.)

-- clangd (C++)
--  FIXME reuse the found clangd-N version in the VimL code here, do not hardcode clangd-15
lspconfig.clangd.setup({
  cmd = {'clangd-15', '--background-index', '--clang-tidy', '--log=verbose', '--enable-config'},
  init_options = {
    fallback_flags = { '-std=c++23', '-I/usr/include/c++/12' },
  },
})
