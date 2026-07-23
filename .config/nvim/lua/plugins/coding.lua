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
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ASAP" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "TMP" } },
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
        multiline = false, -- if `true`, enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = false, -- if `true`, uses treesitter to match keywords in comments only
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

  -- Show code context in the winbar
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('nvim-navic').setup {
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
        },
        highlight = true,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
      }
    end
  },

  -- Nvim Treesitter (main branch): parser management + queries only.
  -- The `main` branch dropped the module system (no `configs.setup`,
  -- `highlight = { enable = true }`, `ensure_installed`, `ts_utils`, ...);
  -- highlighting is started per-buffer via the FileType autocmd below.
  -- Required for Neovim 0.12+, which the legacy `master` branch does not support.
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,        -- main does not self-manage load timing
    build = ':TSUpdate',
    config = function()
      -- ensure_installed is gone; install the parsers we use explicitly (async).
      -- Keep this list one-per-line and alphabetically sorted.
      require('nvim-treesitter').install({
        'bash',
        'c',
        'c_sharp',
        'cmake',
        'cpp',
        'diff',
        'fish',
        'haskell',
        'ini',
        'java',
        'json',
        'kotlin',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'nix',
        'nu',
        'powershell',
        'purescript',
        'python',
        'rust',
        'toml',
        'typescript',
        'vim',
        'xml',
        'yaml',
      })

      -- Make the `shell` code-fence info string resolve to the bash parser
      -- (nvim-treesitter only aliases `sh` -> bash, not `shell`).
      vim.treesitter.language.register('bash', 'shell')

      -- `highlight = { enable = true }` is gone on main; start the highlighter
      -- ourselves for every buffer that has a parser available.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match) or args.match
          -- pcall: silently skip filetypes with no installed parser.
          pcall(vim.treesitter.start, args.buf, lang)
        end,
      })
    end,
  },

  -- Show code context
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require("treesitter-context").setup({
        enable = false,
        mode = 'cursor',
        multiwindow = true,
        max_lines = 4,  -- How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 5,
        trim_scope = 'outer',  -- which context lines to discard
        -- separator = '~',  -- Single character to use as a separator between context and content
      })
    end,
    vim.keymap.set("n", "[^", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true })
  },

  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        use_icons = true,        -- Requires nvim-web-devicons
      })
    end
  },

  -- VSCode-style diff rendering with two-tier highlighting (line + character level) in side-by-side and inline layouts, using VSCode's algorithm implemented in C.
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
  },

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

  -- Opencode: open source AI client
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, '\\$oa', function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "\\$os", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "\\$ot", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "\\$o+",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n",          "\\$o1", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "\\\\<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
      vim.keymap.set("n", "\\\\<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },

  -- GitHub Copilot
  {
    'github/copilot.vim',
    -- { branch = 'release' },
    -- enabled = false, -- FIXME: toggle when the licensing is decided
    config = function()
      vim.cmd([[
      " Use ^X+Tab instead of just Tab for Copilot suggestions
      " (keep Tab for existing non-AI autocompletion)
      imap <silent><script><expr> <C-X><Tab> copilot#Accept("\<CR>")
      let g:copilot_no_tab_map = v:true
      ]])
    end
  },

  -- GitHub Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {  -- See https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#configuration
      model = 'claude-sonnet-4.6',  -- AI model to use
      temperature = 0.1,  -- Lower = focused, higher = creative
      window = {
        layout = 'vertical',  -- 'vertical', 'horizontal', 'float'
        width = 0.5,          -- 50% of screen width
      },
      auto_insert_mode = true,     -- Enter insert mode when opening
    },
  },

  -- Claude Code integration for Neovim
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        -- Terminal window settings
        window = {
          split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
          position = "botright",  -- Position of the window: "botright", "topleft", "vertical", "float", etc.
          enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
          hide_numbers = true,    -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window

          -- Floating window configuration (only applies when position = "float")
          float = {
            width = "80%",        -- Width: number of columns or percentage string
            height = "80%",       -- Height: number of rows or percentage string
            row = "center",       -- Row position: number, "center", or percentage string
            col = "center",       -- Column position: number, "center", or percentage string
            relative = "editor",  -- Relative to: "editor" or "cursor"
            border = "rounded",   -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
          },
        },
        -- File refresh settings
        refresh = {
          enable = true,           -- Enable file change detection
          updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
          timer_interval = 1000,   -- How often to check for file changes (milliseconds)
          show_notifications = true, -- Show notification when files are reloaded
        },
        -- Git project settings
        git = {
          use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
        },
        -- Shell-specific settings
        shell = {
          separator = '&&',        -- Command separator used in shell commands
          pushd_cmd = 'pushd',     -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
          popd_cmd = 'popd',       -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
        },
        -- Command settings
        command = "claude",        -- Command used to launch Claude Code
        -- Command variants
        command_variants = {
          -- Conversation management
          continue = "--continue", -- Resume the most recent conversation
          resume = "--resume",     -- Display an interactive conversation picker

          -- Output options
          verbose = "--verbose",   -- Enable verbose logging with full turn-by-turn output
        },
        -- Keymaps
        keymaps = {
          toggle = {
            normal = "<C-,>",       -- Normal mode keymap for toggling Claude Code, false to disable
            terminal = "<C-,>",     -- Terminal mode keymap for toggling Claude Code, false to disable
            variants = {
              continue = "\\$cc", -- Normal mode keymap for Claude Code with continue flag
              verbose = "\\$cv",  -- Normal mode keymap for Claude Code with verbose flag
            },
          },
          window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
          scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
        }
      })
    end
  },

  -- MCP Hub
  -- https://ravitemer.github.io/mcphub.nvim
  -- {
  --   "ravitemer/mcphub.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
  --   config = function()
  --     require("mcphub").setup()
  --   end
  -- },

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
    config = function()
      -- FIXME: add custom keymaps for nvim-gdb commands (https://github.com/sakhnik/nvim-gdb?tab=readme-ov-file#usage)
    end,
  },

  -- Faster LuaLS setup for Neovim
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Optional cmp completion source for require statements and module annotations
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },

  -- Optional blink completion source for require statements and module annotations
  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     sources = {
  --       -- add lazydev to your completion providers
  --       default = { "lazydev", "lsp", "path", "snippets", "buffer" },
  --       providers = {
  --         lazydev = {
  --           name = "LazyDev",
  --           module = "lazydev.integrations.blink",
  --           -- make lazydev completions top priority (see `:h blink.cmp`)
  --           score_offset = 100,
  --         },
  --       },
  --     },
  --   },
  -- },

  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim

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

  -- LLVM IR support
  {
    'rhysd/vim-llvm',
    ft = { 'llvm' },
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
}
