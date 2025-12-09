----------------------------------------
-- Clojure-specific neovim configuration
----------------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  " setlocal keywordprg=:call\ LanguageClient#textDocument_hover()\ \"

  " setlocal omnifunc=clojurecomplete#Complete

  " -----------------------------------------------------------------------------
  " Apply workspace-specific Clojure settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-clojure.vim"))
      source ~/.workspace-clojure.vim
  endif
]])
