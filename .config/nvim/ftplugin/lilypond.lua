-----------------------------------------
-- Lilypond-specific neovim configuration
-----------------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  " TODO find a command line utility to query Lilypond manuals
  "setlocal keywordprg=hoogle

  nnoremap <buffer> <F1> :!sp-open "http://lilypond.org/doc/v2.18/Documentation/notation/index.html"<CR>

  " search the word under cursor in Lilypond manuals (using browser)
  nnoremap <buffer> \\? :!sp-open "https://duckduckgo.com/?q=site:lilypond.org/doc/ <C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://duckduckgo.com/?q=site:lilypond.org/doc/ <C-r>*"<Left>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific Lilypond settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-lilypond.vim"))
    source ~/.workspace-lilypond.vim
    endif
]])
