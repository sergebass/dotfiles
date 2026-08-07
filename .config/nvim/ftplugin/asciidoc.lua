-----------------------------------------
-- AsciiDoc-specific neovim configuration
-----------------------------------------

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.autoindent = true
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Using gq for formatting will call this function:
vim.opt_local.formatexpr = "SPVentilatedFormatExpr()"
-- vim.opt_local.formatoptions:append("t")  -- Enable automatic formatting of text

vim.cmd([[
  nnoremap <buffer> <F1> :!sp-open "https://docs.asciidoctor.org/asciidoc/latest/"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/"<CR>

  nnoremap <buffer> gO :DoOutline<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific AsciiDoc settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-asciidoc.vim"))
      source ~/.workspace-asciidoc.vim
  endif
]])
