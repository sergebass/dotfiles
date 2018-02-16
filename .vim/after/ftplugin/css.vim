""" --------------------------
""" CSS-SPECIFIC CONFIGURATION
""" --------------------------

" TODO find relevant utilities to do formatting and quick lookup:
" TODO need to try this:
"setlocal equalprg=css-beautify
"setlocal keywordprg=hoogle

nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/cssref/"<CR>

nnoremap <buffer> <LocalLeader>v :Validate<CR>

" adapted from https://stackoverflow.com/a/22865673
nnoremap <buffer> <LocalLeader>= :%s/[{;}]/&\r/g<CR>=
" TODO create a mapping for visual mode (for selected range formatting)
