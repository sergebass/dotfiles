------------------------------------
-- SQL-specific neovim configuration
------------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  " setlocal keywordprg=stack\ hoogle\ --\ --count=100
  " setlocal makeprg=stack\ build

  " setlocal omnifunc=sqlcomplete#Complete

  nnoremap <buffer> <F1> :!sp-open "https://www.w3schools.com/sql/sql_quickref.asp"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://www.postgresql.org/docs/current/sql-commands.html"<CR>

  " search the word under cursor in PostgreSQL database (using browser)
  nnoremap <buffer> \\?p :!sp-open "https://www.postgresql.org/search/?q=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\?p "*y<Esc>:!sp-open "https://www.postgresql.org/search/?q=<C-r>*"<Left>

  " search the word under cursor in MySQL database (using browser)
  nnoremap <buffer> \\?m :!sp-open "https://dev.mysql.com/doc/search/?q=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\?m "*y<Esc>:!sp-open "https://dev.mysql.com/doc/search/?q=<C-r>*"<Left>

  " search the word under cursor in SQLite database (using browser)
  nnoremap <buffer> \\?l :!sp-open "https://sqlite.org/search?q=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\?l "*y<Esc>:!sp-open "https://sqlite.org/search/?q=<C-r>*"<Left>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific SQL settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-sql.vim"))
      source ~/.workspace-sql.vim
  endif
]])
