-----------------------------------------------
-- VimL/VimScript-specific neovim configuration
-----------------------------------------------

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.autoindent = true

-- Jump to definition of the symbol under cursor
-- vim.keymap.set('n', '<CR>', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: Go to definition' })
vim.keymap.set('n', '<CR>', require('telescope.builtin').lsp_definitions, { buffer = true, desc = 'Telescope: LSP: Go to definition (telescope)' })

vim.cmd([[
  nnoremap <buffer> <F1> :!sp-open "https://vimdoc.sourceforge.net/htmldoc/usr_41.html"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://github.com/vim/vim/blob/master/README_VIM9.md"<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific VimL settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-vim.vim"))
      source ~/.workspace-vim.vim
  endif

  if filereadable(expand("~/.workspace-vim.lua"))
      source ~/.workspace-vim.lua
  endif
]])
