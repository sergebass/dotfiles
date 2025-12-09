-----------------------------------------
-- org-mode-specific neovim configuration
-----------------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  " use :make to convert org files to markdown by default
  setlocal makeprg=pandoc\ --to\ markdown\ --from\ org\ %\ -o\ %.md

  nnoremap <buffer> <F1> :!sp-open "https://orgmode.org/manual/"<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific org settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-org.vim"))
      source ~/.workspace-org.vim
  endif
]])
