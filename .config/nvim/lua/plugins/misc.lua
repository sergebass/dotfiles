-- Miscellaneous Neovim plugins that don't fit into other categories

return {
  -- Make Vim handle line and column numbers in file names with a minimum of fuss
  {
    'wsdjeg/vim-fetch',
  },

  -- Fuzzy Finder and more ("Find, Filter, Preview, Pick. All lua, all the time. ")
  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
    end,
  },

  -- Another fuzzy finder, FZF (also compatible with classic Vim)
  {
    "junegunn/fzf",
    dir = "~/.fzf",
    build = "./install --all",
  },

  -- FIXME remove once fzf-lua is working properly
  -- FZF integration for Vim and Neovim
  {
    "junegunn/fzf.vim",
    init = function()
      vim.cmd([[
        " Initialize configuration dictionary
        let g:fzf_vim = {}

        " Prefix all FZF-related commands with "Fzf" to avoid conflicts with other plugins
        let g:fzf_vim.command_prefix = 'Fzf'

        let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }
      ]])
    end,
  },

  -- Improved fzf.vim written in lua 
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    config = function()
      local fzfLua = require("fzf-lua")
      fzfLua.setup({
        -- MISC GLOBAL SETUP OPTIONS, SEE BELOW
        -- fzf_bin = ...,
        -- each of these options can also be passed as function that return options table
        -- e.g. winopts = function() return { ... } end
        -- UI Options
        winopts = {
          -- split = "belowright new",  -- open in a split instead of a floating window
          height = 0.95,              -- window height
          width = 0.95,               -- window width
          -- row = 0.30,                 -- window row position (0=top, 1=bottom)
          -- col = 0.50,                 -- window col position (0=left, 1=right)
          -- border = 'rounded',         -- border kind: 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
          -- fullscreen = false,         -- open fullscreen?
        },
        -- Neovim keymaps / fzf binds
        keymap = {
          -- These are default FzfLua keymaps that are always set unless overridden here
          -- ["ctrl-a"] = "select-all+accept",
          -- ["ctrl-d"] = "half-page-down",
          -- ["ctrl-u"] = "half-page-up",
        },
        -- Fzf "accept" binds
        actions = {
          -- These are default FzfLua actions that are always set unless overridden here
          -- ["default"] = function(selected) print(selected[1]) end,
        },
        -- Fzf CLI flags
        fzf_opts = {
          -- ["--ansi"] = "",
          -- ["--prompt"] = "> ",
          -- ["--pointer"] = "➤ ",
          -- ["--marker"] = "✓ ",
        },
        -- Fzf `--color` specification
        fzf_colors = {
          -- ["fg"] = { "fg", "Normal" },
          -- ["bg"] = { "bg", "Normal" },
          -- ["hl"] = { "fg", "Comment" },
        },
        -- Highlights
        hls = {
          -- ["fzfLuaBorder"] = { fg = "FloatBorder", bg = "Normal" },
          -- ["fzfLuaNormal"] = { fg = "Normal", bg = "Normal" },
          -- ["fzfLuaTitle"] = { fg = "Title", bg = "Normal" },
        },
        -- Previewers options
        previewers = {
          -- builtin = {
          --   syntax = true,  -- preview syntax highlight?
          --   syntax_limit = 10_000,  -- syntax highlight limit (in bytes), set to 0 for no limit
          --   timeout = 700,  -- timeout for previewer startup (in milliseconds)
          -- },
        },
        -- SPECIFIC COMMAND/PICKER OPTIONS, SEE BELOW
        -- files = {
        --   cmd = "find . -type f -printf '%P\n' 2> /dev/null | head -10000",
        -- },
      })

      -- Register fzf-lua as the default UI for vim.ui.select
      fzfLua.register_ui_select()

      -- Configure keymaps for fzf-lua commands
      -- All supported fzf-lua commands are listed here:
      -- https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#commands

      vim.keymap.set('n', "<Space><Space>", fzfLua.commands, { desc = "Commands (fzf-lua)" })
      vim.keymap.set('n', "<Space><Space>?", fzfLua.command_history, { desc = "Command history (fzf-lua)" })

      -- Global search (loosely similar to Quick Open in VSCode)
      vim.keymap.set('n', "<C-P>", fzfLua.global, { desc = "Global lookup (fzf-lua)" })

      -- Help and documentation
      vim.keymap.set('n', "<Space>h<Space>", fzfLua.helptags, { desc = "Help tags (fzf-lua)" })
      vim.keymap.set('n', "<Space>?", fzfLua.keymaps, { desc = "Keymaps (fzf-lua)" })
      vim.keymap.set('n', "<Space>hk", fzfLua.keymaps, { desc = "Keymaps (fzf-lua)" })
      vim.keymap.set('n', "<Space>hm", fzfLua.man_pages, { desc = "Man pages (fzf-lua)" })

      -- Buffers
      vim.keymap.set("n", "<Space>bb", fzfLua.buffers, { desc = "Find buffers (fzf-lua)" })
      vim.keymap.set('n', "<Space>sj", fzfLua.btags, { desc = "Tags in current buffer (fzf-lua)" })
      vim.keymap.set('n', "<C-N>", fzfLua.btags, { desc = "Tags in current buffer (fzf-lua)" })

      -- Files
      vim.keymap.set('n', "<Space>fr", fzfLua.oldfiles, { desc = "Find recently opened files (fzf-lua)" })
      vim.keymap.set("n", "<Space>ff", fzfLua.files, { desc = "Find files (fzf-lua)" })

      -- Projects
      -- Spacemacs shortcuts: https://www.spacemacs.org/doc/DOCUMENTATION.html#managing-projects
      vim.keymap.set("n", "<Space>pf", fzfLua.git_files, { desc = "Find git files (fzf-lua)" })
      vim.keymap.set('n', "<Space>pg", fzfLua.tags, { desc = "Tags in directory (fzf-lua)" })

      -- Git
      vim.keymap.set('n', "<Space>gs", fzfLua.git_status, { desc = "Git status (fzf-lua)" })
      vim.keymap.set('n', "<Space>gl", fzfLua.git_commits, { desc = "Git project commits (fzf-lua)" })
      vim.keymap.set('n', "<Space>gfl", fzfLua.git_bcommits, { desc = "Git buffer commits (fzf-lua)" })
      vim.keymap.set('n', "<Space>gfd", fzfLua.git_diff, { desc = "Git diff (fzf-lua)" })
      vim.keymap.set('n', "<Space>gb", fzfLua.git_blame, { desc = "Git blame (fzf-lua)" })

      -- Search
      vim.keymap.set('n', "<Space>s?", fzfLua.search_history, { desc = "Search history (fzf-lua)" })
      vim.keymap.set('n', "<Space>srp", fzfLua.live_grep, { desc = "Live grep (fzf-lua)" })
      vim.keymap.set('n', "<Space>ss", fzfLua.grep_curbuf, { desc = "Grep current buffer (fzf-lua)" })
      vim.keymap.set('n', "<Space>/", fzfLua.grep_project, { desc = "Grep current project (fzf-lua)" })
      vim.keymap.set('n', "<Space>sp", fzfLua.grep_project, { desc = "Grep current project (fzf-lua)" })
      vim.keymap.set('n', "<Space>*", fzfLua.grep_cword, { desc = "Grep selected word in current project (fzf-lua)" })
      vim.keymap.set('n', "<Space>sP", fzfLua.grep_cword, { desc = "Grep selected word in current project (fzf-lua)" })
    end,
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          -- FIXME: revisit, this was auto-generated or pasted from somewhere:
          mode = { "n", "x" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.register(opts.defaults)
      end
    end,
  },

  -- A file explorer tree for Neovim written in Lua
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,  -- Do not filter out hidden files by default
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')

          local function opts(desc)
            return { desc = 'NvimTree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- Default key mappings
          api.config.mappings.default_on_attach(bufnr)

          -- Custom key mappings
          vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
          vim.keymap.set('n', '<F1>', api.tree.toggle_help, opts('Help'))
          vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up to Parent Directory'))
        end,
      })

      -- Configure NvimTree highlight groups
      -- vim.cmd([[
      --     :hi      NvimTreeExecFile    guifg=#ffa0a0
      --     :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
      --     :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
      --     :hi link NvimTreeImageFile   Title
      -- ]])
    end,
  },

  -- More useful word motions for Vim
  { 'chaoren/vim-wordmotion' },

  --  Extensible Neovim Scrollbar
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end,
  },

  -- Better Rainbow Parentheses
  {
    'kien/rainbow_parentheses.vim',
    config = function()
      vim.cmd([[
      " FIXME replace rainbow parenthese plugin with the one from (?)
      " https://github.com/luochen1990/rainbow (hopefully this works properly)
      "
      " chevron matching mode conflicts with XHTML highlighting so disable it for now
      " FIXME: re-enable for C++ templates?
      "au Syntax * RainbowParenthesesLoadChevrons

      au Syntax * RainbowParenthesesLoadRound
      au Syntax * RainbowParenthesesLoadSquare
      au Syntax * RainbowParenthesesLoadBraces

      au VimEnter * RainbowParenthesesToggle
      ]])
    end
  },

  -- A Vim plugin to copy text to the system clipboard using the ANSI OSC52 sequence.
  {
    'ojroques/vim-oscyank',
    config = function()
      -- Explicitly use OSC-52 sequences to copy to system clipboard (via vim-oscyank plugin)
      vim.cmd([[
        vmap Y <Plug>OSCYankVisual
      ]])
    end,
  },

  -- A Vim plugin that manages your tag files
  { 'ludovicchabant/vim-gutentags' },

  -- Vim plugin that displays tags in a window, ordered by scope
  {
    'preservim/tagbar',
    config = function()
      vim.cmd([[
        let g:tagbar_width=60
        let g:tagbar_show_linenumbers=1 " show absolute line numbers
        let g:tagbar_map_help='<F1>' " do not use ? for help, we need it for reverse search in the window
      ]])
    end,
  },

  -- Tim Pope's vim plugins

  -- capslock.vim: Software caps lock
  { 'tpope/vim-capslock' },

  -- characterize.vim: Unicode character metadata
  { 'tpope/vim-characterize' },

  -- commentary.vim: comment stuff out
  { 'tpope/vim-commentary' },

  -- dispatch.vim: Asynchronous build and test dispatcher
  { 'tpope/vim-dispatch' },

  -- eunuch.vim: Helpers for UNIX
  { 'tpope/vim-eunuch' },

  -- obsession.vim: continuously updated session files
  { 'tpope/vim-obsession' },

  -- repeat.vim: enable repeating supported plugin maps with "."
  { 'tpope/vim-repeat' },

  -- scriptease.vim: A Vim plugin for Vim plugins
  { 'tpope/vim-scriptease' },

  -- :PP: Pretty print. With no argument, acts as a REPL.
  -- :Runtime: Reload runtime files. Like :runtime!, but it unlets any include guards first.
  -- :Disarm: Remove a runtime file's maps, commands, and autocommands, effectively disabling it.
  -- :Scriptnames: Load :scriptnames into the quickfix list.
  -- :Messages: Load :messages into the quickfix list, with stack trace parsing.
  -- :Verbose: Capture the output of a :verbose invocation into the preview window.
  -- :Time: Measure how long a command takes.
  -- :Breakadd: Like its lowercase cousin, but makes it much easier to set breakpoints inside functions. Also :Breakdel.
  -- :Vedit: Edit a file relative the runtime path. For example, :Vedit plugin/scriptease.vim. Also, :Vsplit, :Vtabedit, etc. Extracted from pathogen.vim.
  -- K: Look up the :help for the VimL construct under the cursor.
  -- zS: Show the active syntax highlighting groups under the cursor.
  -- g=: Eval a motion or selection as VimL and replace it with the result. This is handy for doing math, even outside of VimL.

  -- speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
  { 'tpope/vim-speeddating' },

  -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
  { 'tpope/vim-surround' },

  -- unimpaired.vim: Pairs of handy bracket mappings
  { 'tpope/vim-unimpaired' },

  -- vim plugin for tmux.conf
  { 'tmux-plugins/vim-tmux' },

  -- Find-and-Replace (in multiple files)
  -- { 'brooth/far.vim' },

  -- A Sublime-like minimap for VIM, based on the Drawille console-based drawing library
  { 'severin-lemaignan/vim-minimap' },

  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },

  -- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
  { 'junegunn/vim-easy-align' },

  -- " " Any valid git URL is allowed
  -- " Plug 'https://github.com/junegunn/vim-github-dashboard.git'

  -- " " Multiple Plug commands can be written in a single line using | separators
  -- " Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  -- " " On-demand loading
  -- " Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

  -- " " Using a non-master branch
  -- " Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

  -- " " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
  -- " Plug 'fatih/vim-go', { 'tag': '*' }

  -- " " Plugin options
  -- " Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

  -- " " Unmanaged plugin (manually installed and updated)
  -- " Plug '~/my-prototype-plugin'
  -- " Plug '/usr/share/lilypond/2.18.2/vim'

  -- " Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
  -- Plug 'ConradIrwin/vim-bracketed-paste'

  -- " You need to be using a modern xterm-compatible terminal emulator that supports bracketed paste mode. xterm, urxvt, iTerm2, gnome-terminal (and other terminals using libvte), Putty (for Windows) are known to work.

  -- " Then whenever you are in the insert mode and paste into your terminal emulator using command+v, shift+insert, ctrl+shift+v or middle-click, vim will automatically :set paste for you.

  -- " Vim bookmark plugin
  -- Plug 'MattesGroeger/vim-bookmarks'

  -- " Search local vimrc files (".lvimrc") in the tree (root dir up to current dir) and load them.
  -- Plug 'embear/vim-localvimrc'

  -- " do not use sandboxing for local vim scripts (a bit less secure but much less bothersome either)
  -- let g:localvimrc_sandbox=0

  -- " trust all .lvimrc scripts under our home directory
  -- let g:localvimrc_whitelist=[expand("~")]

  -- " (Repo archived) vim plugin to search using the silver searcher (ag)
  -- Plug 'ervandew/ag'

  -- " Perform all your vim insert mode completions with Tab
  -- Plug 'ervandew/supertab'

  -- " apply omni autocompletion when pressing <Tab> (used by supertab plugin)
  -- let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
  -- " do not autocomplete at the start of the line, after a comma or after a space:
  -- let g:SuperTabNoCompleteAfter = ['^', ',', '\s']

  -- " (Repo archived) Smart selection of the closest text object
  -- Plug 'gcmt/wildfire.vim'

  -- " Outline asciidoc(tor) or markdown documents.
  -- Plug 'habamax/vim-do-outline'

  -- if executable('asciidoctor')
  --     " Asciidoctor plugin for Vim
  --     Plug 'habamax/vim-asciidoctor'
  -- endif

  -- " A vim 7.4+ plugin to generate table of contents for Markdown files.
  -- Plug 'mzlogin/vim-markdown-toc'

  -- " Configure markdown TOC generator (vim-markdown-toc plugin)
  -- let g:vmt_auto_update_on_save = 0  " Do not auto-update the TOC on saving
  -- let g:vmt_cycle_list_item_markers = 1  " Do not just use '*' for all nesting levels, cycle through the {*+-} set
  -- let g:vmt_list_item_char = '*'  " The default bullet item character
  -- let g:vmt_fence_text = 'TOC'
  -- let g:vmt_fence_closing_text = '/TOC'

  -- " The interactive scratchpad for hackers.
  -- Plug 'metakirby5/codi.vim'

  -- " Helps you win at grep
  -- Plug 'mhinz/vim-grepper'

  -- " Tame the quickfix window.
  -- Plug 'romainl/vim-qf'

  -- " vim-qf: do not shorten paths in quickfix/local lists
  -- let g:qf_shorten_path = 0
  -- let g:qf_statusline = {}
  -- " let g:qf_statusline.before = %!len(filter(getqflist(), 'v:val.valid'))
  -- " let g:qf_statusline.after = %!len(filter(getqflist(), 'v:val.valid'))
  -- " let g:qf_statusline.before = '%{42} '
  -- " let g:qf_statusline.after = ' %{777}'
  -- " let g:qf_statusline.before = '%<\ %{42}'
  -- " let g:qf_statusline.after = '\ %f%=%l\/%-6L\ \ \ \ \  %{tabpagenr()}'

  -- " A vim plugin to filter entries in Quickfix
  -- Plug 'sk1418/QFGrep'

  -- " True Sublime Text style multiple selections for Vim
  -- Plug 'terryma/vim-multiple-cursors'

  -- " (Repo archived) Syntax checking hacks for vim
  -- " ALE is suggested as the "spiritual successor"
  -- " Plug 'vim-syntastic/syntastic'

  -- " Open a Quickfix item in a window you choose. (Vim plugin)
  -- Plug 'yssl/QFEnter'

  -- " one colorscheme pack to rule them all!
  -- Plug 'flazz/vim-colorschemes'

  -- Supplies :DeleteHiddenBuffers command
  { 'arithran/vim-delete-hidden-buffers' },

  -- A plugin to colorize color names and codes
  { 'chrisbra/Colorizer' },

  -- Emoji abbreviations in Vim
  { 'https://gitlab.com/gi1242/vim-emoji-ab' },

  -- All 256 xterm colors with their RGB equivalents, right in Vim!
  -- Provides :XtermColorTable command.
  { 'guns/xterm-color-table.vim' },

  -- A plugin for viewing vim and nvim startup event timing information
  { 'dstein64/vim-startuptime' },
}
