""" ---------------------------------
""" JSON-SPECIFIC CONFIGURATION
""" ---------------------------------

" I don't like tabs, use spaces throughout
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!xdg-open "https://json-spec.readthedocs.io/reference.html"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://www.w3schools.com/js/js_json_intro.asp"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>
