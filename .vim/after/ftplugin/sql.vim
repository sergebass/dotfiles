""" ---------------------------------
""" SQL-SPECIFIC CONFIGURATION
""" ---------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/sql/sql_quickref.asp"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://www.postgresql.org/docs/current/sql-commands.html"<CR>

" search the word under cursor in PostgreSQL database (using browser)
nnoremap <buffer> <LocalLeader>?p :!xdg-open "https://www.postgresql.org/search/?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> <LocalLeader>?p "*y<Esc>:!xdg-open "https://www.postgresql.org/search/?q=<C-r>*"<Left>

" search the word under cursor in MySQL database (using browser)
nnoremap <buffer> <LocalLeader>?m :!xdg-open "https://dev.mysql.com/doc/search/?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> <LocalLeader>?m "*y<Esc>:!xdg-open "https://dev.mysql.com/doc/search/?q=<C-r>*"<Left>

" search the word under cursor in SQLite database (using browser)
nnoremap <buffer> <LocalLeader>?l :!xdg-open "https://sqlite.org/search?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> <LocalLeader>?l "*y<Esc>:!xdg-open "https://sqlite.org/search/?q=<C-r>*"<Left>
