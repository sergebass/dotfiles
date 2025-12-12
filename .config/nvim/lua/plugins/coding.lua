-- Coding-related plugins and configurations for Neovim

return {
  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      -- FIXME: revisit keymaps
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Project/Workspace Diagnostics",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics",
      },
      -- {
      --   "<leader>cs",
      --   "<cmd>Trouble symbols toggle focus=false<cr>",
      --   desc = "Symbols (Trouble)",
      -- },
      -- {
      --   "<leader>cl",
      --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      --   desc = "LSP Definitions / references / ... (Trouble)",
      -- },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    },
  },

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

    -- Debug Adapter Protocol (DAP) client
    {
      'mfussenegger/nvim-dap',
      config = function()
        require('sergebass.dap')
      end
    },

    -- Display debugging-related information right over the source
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require("nvim-dap-virtual-text").setup {
          enabled = true,                        -- enable this plugin (the default)
          enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true,               -- show stop reason when stopped for exceptions
          commented = true,                      -- prefix virtual text with comment string
          only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
          all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
          clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
          --- A callback that determines how a variable is displayed or whether it should be omitted
          --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
          --- @param buf number
          --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
          --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
          --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
          --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
          display_callback = function(variable, buf, stackframe, node, options)
            -- by default, strip out new line characters
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value:gsub("%s+", " ")
            else
              return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
            end
          end,
          -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
          virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

          -- experimental features:
          all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
          virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
          -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
        }
      end
    },

    -- Modern, minimalistic debugging UI for neovim
    {
      "igorlfs/nvim-dap-view",
      ---@module 'dap-view'
      ---@type dapview.Config
      opts = {},
    },

    -- UI for nvim-dap
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
      config = function()
        require('dapui').setup()

        -- Use nvim-dap events to open and close the windows automatically (:help dap-extensions)
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end
      end
    },

    -- FIXME: configure https://github.com/Jorenar/nvim-dap-disasm

    -- GitHub Copilot
    {
        'github/copilot.vim',
        -- { branch = 'release' },
        enabled = false, -- FIXME: toggle when the licensing is decided
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

        -- Use \~ to switch between header and source files in C and C++ in a vsplit
        vim.keymap.set('n', '\\~', function()
          vim.cmd.vsplit()
          vim.cmd.ClangdSwitchSourceHeader()
        end, { desc = 'Clangd: header-source file toggle (in a vsplit window)' })

        -- Use Space+mga to switch between header and source files in C and C++ (spacemacs style)
        vim.keymap.set('n', '<Space>mga', function()
          vim.cmd.ClangdSwitchSourceHeader()
        end, { desc = 'Clangd: header-source file toggle' })

        -- Use Space+mgA to switch between header and source files in C and C++ in a vsplit (spacemacs style)
        vim.keymap.set('n', '<Space>mgA', function()
          vim.cmd.vsplit()
          vim.cmd.ClangdSwitchSourceHeader()
        end, { desc = 'Clangd: header-source file toggle (in a vsplit window)' })
      end
    },

    -- Gdb, LLDB, pdb/pdb++ and BASHDB integration with NeoVim (a very thin wrapper)
    {
      'sakhnik/nvim-gdb',
      build = function()
        vim.cmd([[
          :!./install.sh \| UpdateRemotePlugins
        ]])
      end,
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
