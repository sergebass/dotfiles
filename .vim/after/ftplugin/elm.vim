""" ------------------------------
""" Elm-specific vim configuration
""" ------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
" nnoremap <buffer> <F1> :!xdg-open "https://haskell.org/hoogle/"<CR>
" nnoremap <buffer> <M-F1> :!xdg-open "https://www.stackage.org"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

" -----------------------------------------------------------------------------
" Apply workspace-specific Elm settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-elm.vim"))
    source ~/.workspace-elm.vim
endif
