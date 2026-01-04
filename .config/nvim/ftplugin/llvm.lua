-------------------------------------------------
-- LLVM IR Assembly-specific neovim configuration
-------------------------------------------------

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.autoindent = true

-- Jump to definition of the symbol under cursor
-- vim.keymap.set('n', '<CR>', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: Go to definition' })
vim.keymap.set('n', '<CR>', require('telescope.builtin').lsp_definitions, { buffer = true, desc = 'Telescope: LSP: Go to definition (telescope)' })

vim.cmd([[
  nnoremap <buffer> <F1> :!sp-open "https://llvm.org/docs/LangRef.html"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://llvm.org/docs/MIRLangRef.html"<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific LLVM IR Assembly settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-llvm.vim"))
      source ~/.workspace-llvm.vim
  endif

  if filereadable(expand("~/.workspace-llvm.lua"))
      source ~/.workspace-llvm.lua
  endif
]])
