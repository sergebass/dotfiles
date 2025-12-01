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
vim.opt.mouse = "ar"  -- Enable mouse use in all modes

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
end

-------------------------------
-- Display/rendering options
-------------------------------

vim.opt.scrollback = 100000  -- Increase default terminal scrollback size
vim.opt.scrolloff = 1  -- Keep at least one line visible above/below cursor

-- Highlight tabs, trailing spaces, and non-breaking spaces
vim.opt.list = true  -- Enable rendering of whitespace characters
vim.opt.listchars:append({ tab = ">." })  -- Show tabs as ">."
vim.opt.listchars:append({ trail = "." })  -- Show trailing spaces as "."
vim.opt.listchars:append({nbsp = "_" })  -- Show non-breaking spaces as "_"

-- Long line handling
vim.opt.wrap = false
vim.opt.sidescroll = 5  -- Number of columns to scroll horizontally
vim.opt.listchars:append({ precedes = "<" })  -- Show when line continues to the left
vim.opt.listchars:append({ extends = ">" })   -- Show when line continues to the right

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

-- Use a Unicode U2551 character (double vertical bar) for vertical split separator
vim.opt.fillchars:append({ vert = "║" })

-- Text folding
vim.opt.foldmethod = "syntax"  -- Fold based on syntax, do not fold by default
vim.opt.foldlevel = 100

-- Diff mode
vim.opt.diffopt:append "iwhite"  -- git diff -b mode (ignore whitespace changes)
vim.opt.diffexpr=""

-- Highlight current cursor position
vim.opt.colorcolumn = "80,120"  -- Mark columns at 80 and 120 characters
vim.opt.cursorline = true  -- Highlight the screen line of the cursor
vim.opt.cursorcolumn = true -- Highlight the screen column of the cursor

vim.cmd([[
    augroup BgHighlight
        autocmd!

        autocmd WinEnter * set colorcolumn=80,120
        autocmd WinEnter * set cursorline
        autocmd WinEnter * set cursorcolumn

        autocmd WinLeave * set colorcolumn=0
        autocmd WinLeave * set nocursorline
        autocmd WinLeave * set nocursorcolumn

    augroup END
]])

-- Undo and backup

vim.opt.backup = false

vim.opt.undofile = true  -- Persist undo history between invocations

-- Do not save undo history for temporary files
vim.cmd([[
    augroup vimrc
        autocmd!
        autocmd BufWritePre /tmp/* setlocal noundofile
    augroup END
]])

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

--------------
-- Text search
--------------

vim.opt.incsearch = true  -- Do incremental searching
vim.opt.hlsearch  = true  -- Highlight search results
vim.opt.wrapscan = false  -- Do not wrap after search results are exhausted
vim.opt.inccommand = "nosplit"  -- Highlight text affected by a substitute command in-place

-- Search tags files relative to the current file, then in the current directory,
-- then going up to the root directory
vim.opt.tags = "./tags,tags;/"

-- Consider dashes as parts of a word (for CSS, lisps, package names etc.)
vim.opt.iskeyword = vim.opt.iskeyword + "-"

-- Pressing K in normal/visual mode will look up the word/selection using this command
vim.opt.keywordprg = ":grep -ws"

vim.cmd([[
    autocmd FileType vim setlocal keywordprg=:help
    autocmd FileType sh setlocal keywordprg=:Man
]])

--------------
-- File search
--------------

-- Double star makes :find look for files recursively
if vim.fn.has("win32") == 1 then
    vim.opt.path = ".,,**"
else
    vim.opt.path = ".,/usr/local/include,/usr/include,,**"
end

-- Use rg (ripgrep) instead of grep, for faster searches
vim.opt.grepprg = "rg -L --sort path --ignore --hidden --vimgrep $*"
vim.opt.grepformat = "%f:%l:%c:%m"

-- NetRW settings

-- Use detailed listing style for netrw
vim.g.netrw_liststyle = 1

-- netrw browser uses tabs to display file lists and this looks really bad with tab highlighting
vim.cmd([[autocmd FileType netrw set nolist]])

-----------------
-- Coding options
-----------------

-- Make it possible to run any shell commands for building,
-- and to capture their output in the quickfix window.
-- Note that additional environment variables can be set here as needed.
vim.opt.makeprg = "env -v"

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

require('scrollbar').setup()
require('nu').setup{}

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
