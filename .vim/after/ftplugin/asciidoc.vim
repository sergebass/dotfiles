""" -----------------------------------
""" AsciiDoc-specific vim configuration
""" -----------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent
setlocal wrap
setlocal linebreak

" Using gq for formatting will call this function:
set formatexpr=SPVentilatedFormatExpr()

nnoremap <buffer> <F1> :!sp-open "https://docs.asciidoctor.org/asciidoc/latest/"<CR>
nnoremap <buffer> <M-F1> :!sp-open "https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/"<CR>

nnoremap <buffer> gO :DoOutline<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific AsciiDoc settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-asciidoc.vim"))
    source ~/.workspace-asciidoc.vim
endif
