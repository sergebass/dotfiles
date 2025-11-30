-- vimrc.lua: the starting point of NeoVim configuration in Lua

------------------
-- GENERAL OPTIONS
------------------

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- configure alternative keyboard layout for Latin characters with diacritics
-- (using dead characters as configured in keymap/accents.vim)
vim.opt.keymap = 'accents'

-- but do not enable alternative layout right away (Use ^^/Ctrl+6 to switch)
-- 0 == :lmap is off and IM is off
vim.opt.iminsert = 0
-- -1 == re-use the value of iminsert
vim.opt.imsearch = -1

-- even though we define our mappings in other files, we need to make sure
-- that leader and local leader keys are established well before then
vim.g.mapleader = "-"
vim.g.maplocalleader = "--"

vim.opt.number = true  -- Enable line numbers
vim.opt.scrolloff = 1  -- Keep at least one line visible above/below cursor
vim.opt.ruler  = true  -- Show the cursor position all the time
vim.opt.rulerformat = "%l:%c%V"

vim.cmd([[source ~/.config/nvim/legacy.vim]])

require'scrollbar'.setup()
require'nu'.setup{}

-- LSP (Language Server Protocol) support and other coding features
require('coding')

-- DAP (Debug Adapter Protocol) support and debugging features
require('debugging')
