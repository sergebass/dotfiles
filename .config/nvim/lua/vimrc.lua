-- vimrc.lua: the starting point of NeoVim configuration in Lua

-- Even though we define our mappings in other files, we need to make sure
-- that leader and local leader keys are established well before then
-- (so that plugins and other code can make use of them).
vim.g.mapleader = "-"
vim.g.maplocalleader = "--"

-- Neovim command-line
vim.opt.showcmd = true  -- Display incomplete commands
vim.opt.history = 1000  -- Keep this many lines of command line history

-- Character encoding
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Input options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backspace = "indent,eol,start"  -- allow backspacing over everything in insert mode

-- Configure alternative keyboard layout for Latin characters with diacritics
-- (using dead characters as configured in keymap/accents.vim)
vim.opt.keymap = 'accents'

-- Do not enable alternative layout by default (Use ^^/Ctrl+6 to switch)
vim.opt.iminsert = 0  -- 0 == :lmap is off and IM is off
vim.opt.imsearch = -1  -- -1 == re-use the value of iminsert

-- Autocompletion options
vim.opt.completeopt = "longest,menuone"
-- vim.opt.completefunc = FIXME
vim.opt.omnifunc = "syntaxcomplete#Complete"

-- Command mode autocompletion
vim.opt.wildmode = "list:longest,full"
vim.opt.wildmenu = true

-- Clipboard options

-- Use system clipboard for all yank, delete, change and put operations
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- Use OSC 52 escape sequences to access system clipboard when using tmux.
-- This requires terminal support; e.g., Alacritty, Kitty, iTerm2, etc.
-- but this makes it possible to use system clipboard even over SSH.
-- See <https://github.com/tmux/tmux/wiki/Clipboard#the-clipboard>
if os.getenv("TMUX") then
    vim.g.clipboard = 'osc52'

    -- vim.g.clipboard = {
    --     name = 'tmux-osc52',
    --     copy = {
    --       ['+'] = function(lines, _)
    --         local joined = table.concat(lines, "\n")
    --         local osc52 = "\27]52;c;" .. vim.fn.systemlist("base64", joined)[1] .. "\a"
    --         vim.fn.system("tmux load-buffer -", osc52)
    --       end,
    --       ['*'] = function(lines, _)
    --         local joined = table.concat(lines, "\n")
    --         local osc52 = "\27]52;c;" .. vim.fn.systemlist("base64", joined)[1] .. "\a"
    --         vim.fn.system("tmux load-buffer -", osc52)
    --       end,
    --     },
    --     paste = {
    --       ['+'] = function()
    --         return vim.fn.systemlist("tmux save-buffer | base64 --decode")
    --       end,
    --       ['*'] = function()
    --         return vim.fn.systemlist("tmux save-buffer | base64 --decode")
    --       end,
    --     },
    -- }
end

-------------------------------
-- Display/rendering options
-------------------------------

vim.opt.scrollback = 100000  -- Increase default terminal scrollback size
vim.opt.scrolloff = 1  -- Keep at least one line visible above/below cursor

-- Highlight tabs, trailing spaces, and non-breaking spaces
vim.opt.list = true  -- Enable rendering of whitespace characters
vim.opt.listchars.tab = ">."
vim.opt.listchars.trail = "."
vim.opt.listchars.nbsp = "_"

-- Long line handling
vim.opt.wrap = false
vim.opt.sidescroll = 5  -- Number of columns to scroll horizontally
vim.opt.listchars.precedes = "<"
vim.opt.listchars.extends = ">"

vim.opt.number = true  -- Enable line numbers

vim.opt.ruler  = true  -- Show the cursor position all the time
vim.opt.rulerformat = "%l:%c%V"

-- Status line configuration
vim.opt.laststatus = 2  -- Always display status line, even with one file being edited
vim.opt.statusline = [[%1*%m%r%* %f %3*%{fugitive#statusline()}%9* %y%{ObsessionStatus()} %=%{tabpagenr()}:#%n "%{v:register} u%B/%{&fenc}/%{&ff} %l:%c%V %p%%/%L]]

-- Customized status line for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.statusline = [[%*%{b:term_title}%9*%=#%n\ %l:%c%V\ %p%%/%L]]
  end,
})

vim.opt.tabline = "%!SPTabLine()"

-- Enable automatic file reloading when changed externally

vim.opt.autoread  = true  -- Automatically reload files changed by external programs
vim.opt.updatetime = 5000  -- Set update time to 5 seconds

local checktime_callback = function()
  vim.cmd("checktime")
end

vim.api.nvim_create_autocmd("FocusGained", { pattern = "*", callback = checktime_callback, })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", callback = checktime_callback, })

-- Check for updates each time cursor stops moving
vim.api.nvim_create_autocmd("CursorHold", { pattern = "*", callback = checktime_callback, })
vim.api.nvim_create_autocmd("CursorHoldI", { pattern = "*", callback = checktime_callback, })

-----------------
-- Search options
-----------------

vim.opt.incsearch = true  -- Do incremental searching
vim.opt.hlsearch  = true  -- Highlight search results
vim.opt.wrapscan = false  -- Do not wrap after search results are exhausted
vim.opt.inccommand = "nosplit"  -- Highlight text affected by a substitute command in-place

vim.cmd([[source ~/.config/nvim/legacy.vim]])

---------------------------------
-- Additional configuration files
---------------------------------

vim.cmd([[runtime sergebass/plugins.vim]])
vim.cmd([[runtime sergebass/functions.vim]])
vim.cmd([[runtime sergebass/commands.vim]])
vim.cmd([[runtime sergebass/keymaps.vim]])
vim.cmd([[runtime sergebass/abbreviations.vim]])
vim.cmd([[runtime sergebass/syntax.vim]])

require'scrollbar'.setup()
require'nu'.setup{}

-- LSP (Language Server Protocol) support and other coding features
require('coding')

-- DAP (Debug Adapter Protocol) support and debugging features
require('debugging')

--------------------------------------------------------------------------------
-- apply workspace-specific settings, if available;
-- this is placed at the end to make sure workspace configuration takes priority
-- and possibly overrides our stock mappings (including the above)
--------------------------------------------------------------------------------

vim.cmd([[
    if filereadable(expand("~/.workspace.vim"))
        " workspace-specific settings that should not be tracked in this git repo
        source ~/.workspace.vim
    endif

    if filereadable(expand("~/.workspace.lua"))
        " workspace-specific settings that should not be tracked in this git repo
        source ~/.workspace.lua
    endif
]])
