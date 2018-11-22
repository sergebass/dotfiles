""" ------------------------------
""" IDRIS-SPECIFIC CONFIGURATION
""" ------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!xdg-open "https://www.idris-lang.org/documentation/"<CR>
nnoremap <buffer> <C-F1> :!xdg-open "http://docs.idris-lang.org/en/latest/"<CR>

" search the word under cursor in Idris documentation database (using browser)
nnoremap <buffer> <LocalLeader>? :!xdg-open "http://docs.idris-lang.org/en/latest/search.html?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> <LocalLeader>? "*y<Esc>:!xdg-open "http://docs.idris-lang.org/en/latest/search.html?q=<C-r>*"<Left>

" nnoremap <buffer> <LocalLeader>sc :!stack clean<CR>
" nnoremap <buffer> <LocalLeader>sb :!stack build<CR>
" nnoremap <buffer> <LocalLeader>st :!stack test<CR>
" nnoremap <buffer> <LocalLeader>si :!stack install<CR>
" nnoremap <buffer> <LocalLeader>sr :term stack repl<CR>
