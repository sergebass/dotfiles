""" ---------------------------
""" HTML-SPECIFIC CONFIGURATION
""" ---------------------------

" TODO find relevant utilities to do formatting and quick lookup:
"setlocal equalprg=html-tidy
"setlocal keywordprg=hoogle

nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/tags/default.asp"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://dev.w3.org/html5/html-author/"<CR>

nnoremap <buffer> <LocalLeader>g :BrowserOpen<CR>
nnoremap <buffer> <LocalLeader>v :Validate<CR>

" TODO add a mapping for xmllint --html (?)
"noremap <buffer> <LocalLeader>= <Esc>:XmlFormat<CR>
