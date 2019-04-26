""" ------------------------------
""" FREGE-SPECIFIC CONFIGURATION
""" ------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!xdg-open "http://www.frege-lang.org/doc/fregedoc.html"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "http://www.frege-lang.org/doc/"<CR>

" search the word under cursor in Hoogle database (using browser)
nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

