""" --------------------------
""" JSP-SPECIFIC CONFIGURATION
""" --------------------------

" TODO find relevant utilities to do formatting and quick lookup:
"setlocal equalprg=css-beautify
"setlocal keywordprg=hoogle

call SuperTabSetDefaultCompletionType("<C-N>")

nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/xml/dom_nodetype.asp"<CR>

nnoremap <buffer> <LocalLeader>v :Validate<CR>

" TODO add a mapping for xmllint
nnoremap <buffer> <LocalLeader>~ :XmlFormat<CR>
