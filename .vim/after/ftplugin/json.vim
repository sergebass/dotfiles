""" ---------------------------------
""" JSON-SPECIFIC CONFIGURATION
""" ---------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!xdg-open "https://json-spec.readthedocs.io/reference.html"<CR>
nnoremap <buffer> <C-F1> :!xdg-open "https://www.w3schools.com/js/js_json_intro.asp"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> <LocalLeader>? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> <LocalLeader>? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>
