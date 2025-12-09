---------------------------------------
-- Tagbar-specific neovim configuration
---------------------------------------

vim.cmd([[
  " make sure our <Space> shortcut works in all windows, even in Tagbar :)
  let tagbar_map_showproto = "<M-CR>"

  " -----------------------------------------------------------------------------
  " Apply workspace-specific Tagbar settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-tagbar.vim"))
      source ~/.workspace-tagbar.vim
  endif
]])
