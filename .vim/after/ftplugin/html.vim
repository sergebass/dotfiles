""" ---------------------------
""" HTML-SPECIFIC CONFIGURATION
""" ---------------------------

" TODO find relevant utilities to do formatting and quick lookup:
"setlocal equalprg=css-beautify
"setlocal keywordprg=hoogle

nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/tags/default.asp"<CR>

nnoremap <buffer> <LocalLeader>g :BrowserOpen<CR>
nnoremap <buffer> <LocalLeader>v :Validate<CR>

" TODO add a mapping for xmllint --html (?)
"noremap <buffer> <LocalLeader>= <Esc>:XmlFormat<CR>
