""" ------------------------------
""" SQL-specific vim configuration
""" ------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/sql/sql_quickref.asp"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://www.postgresql.org/docs/current/sql-commands.html"<CR>

" search the word under cursor in PostgreSQL database (using browser)
nnoremap <buffer> \\?p :!xdg-open "https://www.postgresql.org/search/?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?p "*y<Esc>:!xdg-open "https://www.postgresql.org/search/?q=<C-r>*"<Left>

" search the word under cursor in MySQL database (using browser)
nnoremap <buffer> \\?m :!xdg-open "https://dev.mysql.com/doc/search/?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?m "*y<Esc>:!xdg-open "https://dev.mysql.com/doc/search/?q=<C-r>*"<Left>

" search the word under cursor in SQLite database (using browser)
nnoremap <buffer> \\?l :!xdg-open "https://sqlite.org/search?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?l "*y<Esc>:!xdg-open "https://sqlite.org/search/?q=<C-r>*"<Left>

" -----------------------------------------------------------------------------
" Apply workspace-specific SQL settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-sql.vim"))
    source ~/.workspace-sql.vim
endif
