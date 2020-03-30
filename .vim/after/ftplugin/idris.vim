""" --------------------------------
""" Idris-specific vim configuration
""" --------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
" setlocal makeprg=stack\ build

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
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

" -----------------------------------------------------------------------------
" Apply workspace-specific Idris settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-idris.vim"))
    source ~/.workspace-idris.vim
endif
