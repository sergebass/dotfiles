-- vimrc.lua: NeoVim configuration in Lua

require'scrollbar'.setup()
require'nu'.setup{}

-- LSP (Language Server Protocol) support and other coding features
require('coding')

-- DAP (Debug Adapter Protocol) support and debugging features
require('debugging')
