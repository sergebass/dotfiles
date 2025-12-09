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

-- Input abbreviations
vim.cmd([[runtime sergebass/abbreviations.vim]])

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

-- Use OSC 52 escape sequences to access system clipboard when using tmux or SSH.
-- This requires terminal support; e.g., Alacritty, Kitty, iTerm2, etc.
-- but this makes it possible to use system clipboard even over SSH.
-- See <https://github.com/tmux/tmux/wiki/Clipboard#the-clipboard>
if os.getenv("SSH_CONNECTION") or os.getenv("TMUX") then
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

vim.opt.backup = false  -- Do not create backup files
vim.opt.swapfile = true  -- Create swap files
vim.opt.undofile = true  -- Do persist undo history between invocations

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

---------------------------------------------------
-- File creation and reading (filetype tweaks etc.)
---------------------------------------------------

-- Make sure configuration files have the right filetypes
vim.cmd([[au BufNewFile,BufReadPost */gitconfig set filetype=gitconfig]])
vim.cmd([[au BufNewFile,BufReadPost */_gitconfig set filetype=gitconfig]])
vim.cmd([[au BufNewFile,BufReadPost */.vrapperrc set filetype=vim]])
vim.cmd([[au BufNewFile,BufReadPost */.xmobarrc set filetype=haskell]])

-- Force .h and .inl files to be treated as C++ headers
vim.cmd([[au BufNewFile,BufReadPost *.h set filetype=cpp]])
vim.cmd([[au BufNewFile,BufReadPost *.inl set filetype=cpp]])

vim.cmd([[au BufNewFile,BufReadPost *.nasm set filetype=asm]])

vim.cmd([[au BufNewFile,BufReadPost *.gdb set filetype=gdb]])

-- Frege sources are very much Haskell-like
vim.cmd([[au BufNewFile,BufReadPost *.fr set filetype=frege syntax=haskell]])

vim.cmd([[au BufNewFile,BufReadPost *.frag,*.vert,*.fp,*.vp,*.glsl set filetype=glsl]])

-----------------
-- Coding options
-----------------

-- Make it possible to run any shell commands for building,
-- and to capture their output in the quickfix window.
-- Note that additional environment variables can be set here as needed.
vim.opt.makeprg = "env -v"

-- Treat '//' comments as comments in JSON files
vim.cmd([[autocmd FileType json syntax match Comment +\/\/.\+$+]])

---------------------------------
-- Custom functions and commands
---------------------------------

vim.cmd([[runtime sergebass/functions.vim]])
vim.cmd([[runtime sergebass/commands.vim]])

----------------------
-- Syntax highlighting
----------------------

vim.opt.redrawtime = 5000  -- Time in milliseconds for syntax redraw

vim.cmd([[runtime sergebass/syntax.vim]])

-- Disable syntax highlighting for large files (over 1 MB)
vim.cmd([[autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif]])

-------------------------
-- Misc. TUI/GUI settings
-------------------------

-- FIXME extract and refactor all vim.cmd calls
vim.cmd([[
    " Automatically pick correct templates based on the specified file name extension
    augroup templates
      au!
      autocmd BufNewFile *.* silent! execute '0r ~/templates/vim-template.'.expand("<afile>:e")
    augroup END

    au BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

    " remember edit position and jump to it next time the same file is edited
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " if exists("syntax_on")
    "   syntax reset
    " endif

    " " Clear filetype flags before changing runtimepath to force Vim to reload them.
    " if exists("g:did_load_filetypes")
    "     filetype off
    "     filetype plugin indent off
    " endif

    filetype plugin indent on
    syntax on

    " this is useful for nested terminals, to make them use the existing nvim instance, if available
    if executable("nvr")
        let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    endif

    " -------------------
    " GENERAL UI SETTINGS
    " -------------------

    set guifont=Inconsolata:h11

    if $TERM == "linux"
    \ || $TERM == "screen-256color"
    \ || $TERM == "xterm-256color"
    \ || $TERM == "rxvt-unicode-256color"
    \ || $COLORTERM == "xfce4-terminal"
    \ || $COLORTERM == "gnome-terminal"
    \ || $COLORTERM == "Terminal"
      set t_Co=256

      " disable Background Color Erase (BCE) so that color schemes
      " render properly when inside 256-color tmux and GNU screen.
      " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
      set t_ut=
    endif

    " if we're in non-tty tmux session running neovim,
    " we may try using 24-bit GUI color scheme settings directly
    if $TMUX != "" && $TERM != "linux"
        " nvim is compiled with this feature, vim is most likely not
        " this setting may seem to conflict with the above
        " but since 24-bit colors are automatically mapped to their closest
        " 256-color counterparts, we may get away with this,
        " and this will work best in terminals with true 24-bit color support
        set termguicolors
    endif

    " make sure tmux correctly passes DECSCUSR cursor shape change sequences
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    else
      let &t_SI = "\e[5 q"
      let &t_EI = "\e[2 q"
    endif

    " FIXME Uncomment when it's clear how to make this work with urxvt...
    " if &term =~ '^xterm\\|rxvt'
    "   " use an orange cursor in insert mode
    "   let &t_SI = "\<Esc>]12;orange\x7"
    "   " use a red cursor otherwise
    "   let &t_EI = "\<Esc>]12;red\x7"
    "   silent !echo -ne "\033]12;red\007"
    "   " reset cursor when vim exits
    "   autocmd VimLeave * silent !echo -ne "\033]112\007"
    "   " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
    "
    "   " solid underscore
    "   let &t_SI .= "\<Esc>[4 q"
    "   " solid block
    "   let &t_EI .= "\<Esc>[2 q"
    "   " 1 or 0 -> blinking block
    "   " 3 -> blinking underscore
    "   " Recent versions of xterm (282 or above) also support
    "   " 5 -> blinking vertical bar
    "   " 6 -> solid vertical bar
    " endif

    " use a dark theme by default (there's a shortcut to quickly switch it, if needed)
    " (one other option may be to have the "if &termguicolors" check for auto detection)
    colorscheme sergebass-dark

    " try to use transparent background, if supported (see background erasure (BCE) mode in terminals)
    if !(exists("g:GuiLoaded") || has("gui_running")) " GUI vim/neovim versions don't support transparent backgrounds
        hi Normal ctermbg=NONE guibg=NONE
    endif
]])

-------------------------------
-- Configure additional plugins
-------------------------------

require('plugins-lazy')

--------------------------
-- Custom kyboard mappings
--------------------------

require('sergebass.keymaps')

--------------------------------------------------------------------------------
-- Apply workspace-specific settings, if available.
-- This is placed at the end to make sure workspace configuration takes priority,
-- and possibly overrides our stock settings (including the above)
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
