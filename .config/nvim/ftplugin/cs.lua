-----------------------------------
-- C#-specific neovim configuration
-----------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  " for some reason vim-commentary uses /* */ C-style commenting, but let's use // instead
  setlocal commentstring=//\ %s

  nnoremap <buffer> <F1> :!sp-open "https://learn.microsoft.com/en-us/dotnet/api/"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://learn.microsoft.com/en-us/dotnet/csharp"<CR>
]])
