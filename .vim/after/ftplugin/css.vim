""" --------------------------
""" CSS-SPECIFIC CONFIGURATION
""" --------------------------

" TODO find relevant utilities to do formatting and quick lookup:
"setlocal equalprg=cssbeautify
"setlocal keywordprg=hoogle

nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/cssref/"<CR>

nnoremap <buffer> <LocalLeader>v :Validate<CR>

" adapted from https://stackoverflow.com/a/22865673
" FIXME this doesn't produce good output;
"nnoremap <buffer> <LocalLeader>= :%s/[{;}]/&\r/g<CR>gg=G
" TODO create a mapping for visual mode (for selected range formatting)
