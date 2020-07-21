""" ---------------------------------
""" Python-specific vim configuration
""" ---------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=ri

" nnoremap <buffer> <F1> :!sp-open "https://rubyapi.org/"<CR>

" search the word under cursor in the Ruby API database (using browser)
" nnoremap <buffer> \\? :!sp-open "https://rubyapi.org/2.7/o/s?q=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://rubyapi.org/2.7/o/s?q=<C-r>*"<Left>

" -----------------------------------------------------------------------------
" Apply workspace-specific Python settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-python.vim"))
    source ~/.workspace-python.vim
endif
