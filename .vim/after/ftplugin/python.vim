""" ---------------------------------
""" Python-specific vim configuration
""" ---------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=ri

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
" nnoremap <buffer> <F1> :!xdg-open "https://rubyapi.org/"<CR>

" search the word under cursor in the Ruby API database (using browser)
" nnoremap <buffer> \\? :!xdg-open "https://rubyapi.org/2.7/o/s?q=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://rubyapi.org/2.7/o/s?q=<C-r>*"<Left>

" -----------------------------------------------------------------------------
" Apply workspace-specific Python settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-python.vim"))
    source ~/.workspace-python.vim
endif
