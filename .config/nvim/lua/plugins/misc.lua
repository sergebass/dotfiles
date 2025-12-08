return {
  {
    "junegunn/fzf",
    dir = "~/.fzf",
    build = "./install --all",
  },

  { "junegunn/fzf.vim", },

  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    opts = {},
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

  -- Basic editor support for the nushell language
  -- {
  --   'LhKipp/nvim-nu',
  --   ft = { 'nu' },
  --   build = ':TSInstall nu',
  --   config = function()
  --     require('nu').setup()
  --   end,
  -- },

  -- A Vim plugin to copy text to the system clipboard using the ANSI OSC52 sequence.
  {'ojroques/vim-oscyank' },

  -- A Vim plugin that manages your tag files
  { 'ludovicchabant/vim-gutentags' },

  -- Vim plugin that displays tags in a window, ordered by scope
  {
    'majutsushi/tagbar',
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

    -- dadbod.vim: Modern database interface for Vim
    { 'tpope/vim-dadbod' },

    -- dispatch.vim: Asynchronous build and test dispatcher
    { 'tpope/vim-dispatch' },

    -- eunuch.vim: Helpers for UNIX
    { 'tpope/vim-eunuch' },

    -- fugitive.vim: A Git wrapper so awesome, it should be illegal
    { 'tpope/vim-fugitive' },

    -- obsession.vim: continuously updated session files
    { 'tpope/vim-obsession' },

    -- repeat.vim: enable repeating supported plugin maps with "."
    { 'tpope/vim-repeat' },

    -- rhubarb.vim: GitHub extension for fugitive.vim
    { 'tpope/vim-rhubarb' },

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

    -- A git commit browser
    { 'junegunn/gv.vim' },

    -- vim UI plugin for tpope/dadbod
    { 'kristijanhusak/vim-dadbod-ui' },

    -- Find-and-Replace (in multiple files)
    -- { 'brooth/far.vim' },

    {
        'github/copilot.vim',
        -- { branch = 'release' },
        config = function()
            vim.cmd([[
                " Use ^X+Tab instead of just Tab for Copilot suggestions
                " (keep Tab for existing non-AI autocompletion)
                imap <silent><script><expr> <C-X><Tab> copilot#Accept("\<CR>")
                let g:copilot_no_tab_map = v:true
            ]])
        end
    },

    -- A tree explorer plugin for vim.
    {
       'scrooloose/nerdtree',
       setup = function()
           vim.cmd([[
             let g:NERDTreeMapHelp='<F1>' " do not use ? for help, we need it for reverse search in the window
             let g:NERDTreeShowLineNumbers=1
             let g:NERDTreeShowHidden=1
             let g:NERDTreeWinSize=64
             let g:NERDTreeQuitOnOpen=1 " close NERDtree window after opening a file
           ]])
       end,
    },

    -- A Sublime-like minimap for VIM, based on the Drawille console-based drawing library
    { 'severin-lemaignan/vim-minimap' },

    -- (Repo archived) Yet another EditorConfig (http://editorconfig.org) plugin for vim written in vimscript only
    { 'sgur/vim-editorconfig' },

    -- A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
    {
        'airblade/vim-gitgutter',
        config = function()
            vim.cmd([[
                " Enable gitgutter
                let g:gitgutter_enabled = 1

                " git gutter: pass this option to git diff
                let g:gitgutter_diff_args = '-w'

                " Update gitgutter every 1000ms
                let g:gitgutter_update_interval = 1000

                " Show line numbers in gitgutter signs
                let g:gitgutter_sign_column_always = 1

                " Use a minimal set of signs
                let g:gitgutter_sign_added = '│'
                let g:gitgutter_sign_modified = '│'
                let g:gitgutter_sign_removed = '‾'

                " Key mappings for gitgutter
                nmap <leader>gh :GitGutterPreviewHunk<CR>
                nmap <leader>gs :GitGutterStageHunk<CR>
                nmap <leader>gu :GitGutterUndoHunk<CR>
                nmap <leader>gp :GitGutterPreviewHunk<CR>
            ]])
        end
        },

    -- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    { 'junegunn/vim-easy-align' },

    -- " " Any valid git URL is allowed
    -- " Plug 'https://github.com/junegunn/vim-github-dashboard.git'

    -- " " Multiple Plug commands can be written in a single line using | separators
    -- " Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    -- " " On-demand loading
    -- " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
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

    -- " Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.
    -- "Plug 'ctrlpvim/ctrlp.vim'

    -- "let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:100'
    -- "let g:ctrlp_extensions = [
    -- "\ 'tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
    -- "\ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir'
    -- "\ ]

    -- " Autocompletion plus many other things (needs vim with Python)
    -- " Plug 'ycm-core/YouCompleteMe'

    -- " ALE (Asynchronous Lint Engine)
    -- " Plug 'dense-analysis/ale'

    -- if executable('rustc')
    --     " Vim configuration for Rust.
    --     Plug 'rust-lang/rust.vim'
    -- endif

    -- " Do not auto-save buffers after running :RustFmt
    -- let g:rustfmt_autosave = 0

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

    -- if executable('nix')
    --     " Vim configuration files for Nix http://nixos.org/nix
    --     Plug 'LnL7/vim-nix'
    -- endif

    -- if executable('ghc') || executable('ghci')
    --     " Custom Haskell Vimscripts
    --     " Does this plugin work with traditional Vim despite the user name?
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

    -- " Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
    -- Plug 'ConradIrwin/vim-bracketed-paste'

    -- " You need to be using a modern xterm-compatible terminal emulator that supports bracketed paste mode. xterm, urxvt, iTerm2, gnome-terminal (and other terminals using libvte), Putty (for Windows) are known to work.

    -- " Then whenever you are in the insert mode and paste into your terminal emulator using command+v, shift+insert, ctrl+shift+v or middle-click, vim will automatically :set paste for you.

    -- " Vim bookmark plugin
    -- Plug 'MattesGroeger/vim-bookmarks'

    -- " (Repo archived) A plugin of NERDTree showing git status
    -- Plug 'Xuyuanp/nerdtree-git-plugin'

    -- " Supplies :DeleteHiddenBuffers command
    -- Plug 'arithran/vim-delete-hidden-buffers'

    -- " More useful word motions for Vim
    -- Plug 'chaoren/vim-wordmotion'

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

    -- " Better Rainbow Parentheses
    -- Plug 'kien/rainbow_parentheses.vim'

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

    -- " Text outlining and task management for Vim based on Emacs' Org-Mode
    -- Plug 'jceb/vim-orgmode'

    -- " Make Vim handle line and column numbers in file names with a minimum of fuss
    -- Plug 'kopischke/vim-fetch'

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

    -- " Emoji abbreviations in Vim
    -- Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

    -- " A plugin to colorize color names and codes
    -- Plug 'chrisbra/Colorizer'

    -- " one colorscheme pack to rule them all!
    -- Plug 'flazz/vim-colorschemes'

    -- " All 256 xterm colors with their RGB equivalents, right in Vim!
    -- " Provides :XtermColorTable command.
    -- Plug 'guns/xterm-color-table.vim'

    -- " A plugin for viewing vim and nvim startup event timing information
    -- Plug 'dstein64/vim-startuptime'

    -- runtime sergebass/coding.vim
    -- runtime sergebass/debugging.vim

    -- "  Quickstart configs for Nvim LSP
    -- Plug 'neovim/nvim-lspconfig'

    -- set omnifunc=v:lua.vim.lsp.omnifunc
    -- set tagfunc=v:lua.vim.lsp.tagfunc

    -- " Nvim Treesitter configurations and abstraction layer
    -- Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

    -- " Emacs org-mode support
    -- Plug 'nvim-orgmode/orgmode'

    -- " Asynchronous linter
    -- Plug 'mfussenegger/nvim-lint'

    -- " Support Debug Adapter Protocol plugins
    -- Plug 'mfussenegger/nvim-dap'

    -- " support of native debuggers (gdb, lldb, pdb etc.)
    -- " Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

    -- " NuShell support: "All the lua functions I don't want to write twice."
    -- Plug 'nvim-lua/plenary.nvim'

    -- " null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    -- Plug 'nvimtools/none-ls.nvim'

    -- if executable('nu')
    --     " Basic editor support for the nushell language
    --     Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}
    -- endif

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

    -- FIXME: TODO
    -- LSP (Language Server Protocol) support and other coding features
    -- require('coding')

    -- FIXME: TODO
    -- DAP (Debug Adapter Protocol) support and debugging features
    -- require('debugging')

}
