------------------------------------------------
-- Quickfix-window-specific neovim configuration
------------------------------------------------

vim.cmd([[
  setlocal wrap
  setlocal statusline=%t%{exists('w:quickfix_title')?'\ '.w:quickfix_title:''}%=%l:\ %p%%/%L

  " open selected line file in a new vertical split
  nnoremap <silent> <buffer> \\v <C-w><CR><C-w>H:copen<CR>
  " open selected line file in a new horizontal split
  nnoremap <silent> <buffer> \\s <C-w><CR>
  " open selected line file in a new tab
  nnoremap <silent> <buffer> \\t <C-w><CR><C-w>T

  " -----------------------------------------------------------------------------
  " Apply workspace-specific QuickFix settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-qf.vim"))
      source ~/.workspace-qf.vim
  endif
]])
