------------------------------------
-- CSS-specific neovim configuration
------------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  " TODO find relevant utilities to do formatting and quick lookup:
  "setlocal equalprg=cssbeautify
  "setlocal keywordprg=hoogle

  " setlocal omnifunc=csscomplete#CompleteCSS

  nnoremap <buffer> <F1> :!sp-open "https://www.w3schools.com/cssref/"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://developer.mozilla.org/en-US/docs/Web/CSS/Reference"<CR>

  nnoremap <buffer> \\v :Validate<CR>

  " adapted from https://stackoverflow.com/a/22865673
  " FIXME this doesn't produce good output;
  "nnoremap <buffer> \\= :%s/[{;}]/&\r/g<CR>gg=G
  " TODO create a mapping for visual mode (for selected range formatting)

  " -----------------------------------------------------------------------------
  " Apply workspace-specific CSS settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-css.vim"))
      source ~/.workspace-css.vim
  endif
]])
