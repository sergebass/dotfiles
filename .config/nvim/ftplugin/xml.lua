------------------------------------
-- XML-specific neovim configuration
------------------------------------

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.autoindent = true

-- Use xmllint to reformat XML files
vim.opt_local.equalprg = "xmllint --format --recover -"

vim.cmd([[
  nnoremap <buffer> <F1> :!sp-open "https://www.w3schools.com/xml/dom_nodetype.asp"<CR>

  " Validate the current XML file with xmllint (do not fetch external DTDs)
  nnoremap <buffer> \\v :!xmllint --nonet %<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific XML settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-xml.vim"))
      source ~/.workspace-xml.vim
  endif

  if filereadable(expand("~/.workspace-xml.lua"))
      source ~/.workspace-xml.lua
  endif
]])
