-- vimrc.lua: the starting point of NeoVim configuration in Lua

vim.cmd([[source ~/.config/nvim/legacy.vim]])

require'scrollbar'.setup()
require'nu'.setup{}

-- LSP (Language Server Protocol) support and other coding features
require('coding')

-- DAP (Debug Adapter Protocol) support and debugging features
require('debugging')
