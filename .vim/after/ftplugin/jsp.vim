""" ------------------------------
""" JSP-specific vim configuration
""" ------------------------------

" TODO find relevant utilities to do formatting and quick lookup:
"setlocal equalprg=css-beautify
"setlocal keywordprg=hoogle

call SuperTabSetDefaultCompletionType("<C-N>")

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/xml/dom_nodetype.asp"<CR>

nnoremap <buffer> \\v :Validate<CR>

" TODO add a mapping for xmllint
nnoremap <buffer> \\~ :XmlFormat<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific JSP settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-jsp.vim"))
    source ~/.workspace-jsp.vim
endif
