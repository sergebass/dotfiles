--------------------------------------
-- Shell-specific neovim configuration
--------------------------------------

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.autoindent = true

-- Jump to definition of the symbol under cursor
-- vim.keymap.set('n', '<CR>', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: Go to definition' })
vim.keymap.set('n', '<CR>', require('telescope.builtin').lsp_definitions, { buffer = true, desc = 'Telescope: LSP: Go to definition (telescope)' })

vim.cmd([[
  nnoremap <buffer> <F1> :!sp-open "https://www.gnu.org/software/bash/manual/bash.html"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://man.archlinux.org/man/bash.1"<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific shell settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-sh.vim"))
      source ~/.workspace-sh.vim
  endif

  if filereadable(expand("~/.workspace-sh.lua"))
      source ~/.workspace-sh.lua
  endif
]])
