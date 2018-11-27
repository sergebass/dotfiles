""" ---------------------------------
""" TYPESCRIPT-SPECIFIC CONFIGURATION
""" ---------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!xdg-open "https://www.typescriptlang.org/docs/home.html"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://dev.w3.org/html5/html-author/"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> <LocalLeader>? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> <LocalLeader>? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>
