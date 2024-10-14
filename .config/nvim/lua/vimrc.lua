-- vimrc.lua: NeoVim configuration in Lua

require'scrollbar'.setup()
require'nu'.setup{}

-- Neovim-specific built-in LSP client configuration
lspconfig = require'lspconfig'

-- rust-analyzer (Rust)
lspconfig.rust_analyzer.setup({
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- ccls (C++)
lspconfig.ccls.setup{}

-- FIXME implement project-specific configuration: (different C++ language standards etc.)

-- clangd (C++)
--  FIXME reuse the found clangd-N version in the VimL code here, do not hardcode clangd-15
lspconfig.clangd.setup({
    cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--enable-config'},
    init_options = {
        fallback_flags = { '-std=c++23', '-I/usr/include/c++/12' },
    },
})

-- typescript-language-server (Typescript & Javascript)
lspconfig.ts_ls.setup({
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = {"javascript", "typescript", "vue"},
            },
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "vue",
    },
})
