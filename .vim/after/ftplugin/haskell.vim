""" ------------------------------
""" HASKELL-SPECIFIC CONFIGURATION
""" ------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

setlocal keywordprg=stack\ hoogle\ --\ --count=100
setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!xdg-open "https://haskell.org/hoogle/"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://www.stackage.org"<CR>

" search the word under cursor in Hoogle database (using browser)
nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

nnoremap <buffer> \\sc :!stack clean<CR>
nnoremap <buffer> \\sb :!stack build<CR>
nnoremap <buffer> \\st :!stack test<CR>
nnoremap <buffer> \\si :!stack install<CR>
nnoremap <buffer> \\sr :term stack repl<CR>
