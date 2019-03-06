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
nnoremap <buffer> <M-F1> :!xdg-open "http://docs.idris-lang.org/en/latest/"<CR>

" search the word under cursor in Idris documentation database (using browser)
nnoremap <buffer> \\? :!xdg-open "http://docs.idris-lang.org/en/latest/search.html?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\? "*y<Esc>:!xdg-open "http://docs.idris-lang.org/en/latest/search.html?q=<C-r>*"<Left>

" nnoremap <buffer> \\sc :!stack clean<CR>
" nnoremap <buffer> \\sb :!stack build<CR>
" nnoremap <buffer> \\st :!stack test<CR>
" nnoremap <buffer> \\si :!stack install<CR>
" nnoremap <buffer> \\sr :term stack repl<CR>
