""" -------------------------------
""" JSON-specific vim configuration
""" -------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

nnoremap <buffer> <F1> :!sp-open "https://json-spec.readthedocs.io/reference.html"<CR>
nnoremap <buffer> <M-F1> :!sp-open "https://www.w3schools.com/js/js_json_intro.asp"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

" -----------------------------------------------------------------------------
" Apply workspace-specific JSON settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-json.vim"))
    source ~/.workspace-json.vim
endif
