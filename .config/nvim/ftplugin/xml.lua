------------------------------------
-- XML-specific neovim configuration
------------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  " TODO find relevant utilities to do formatting and quick lookup:
  "setlocal equalprg=css-beautify
  "setlocal keywordprg=hoogle

  " setlocal omnifunc=xmlcomplete#CompleteTags

  call SuperTabSetDefaultCompletionType("<C-N>")

  nnoremap <buffer> <F1> :!sp-open "https://www.w3schools.com/xml/dom_nodetype.asp"<CR>

  nnoremap <buffer> \\v :Validate<CR>

  " TODO add a mapping for xmllint
  nnoremap <buffer> \\~ :XmlFormat<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific XML settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-xml.vim"))
      source ~/.workspace-xml.vim
  endif
]])
