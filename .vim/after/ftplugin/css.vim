""" --------------------------
""" CSS-SPECIFIC CONFIGURATION
""" --------------------------

" TODO find relevant utilities to do formatting and quick lookup:
"setlocal equalprg=cssbeautify
"setlocal keywordprg=hoogle

nnoremap <buffer> <F1> :!xdg-open "https://www.w3schools.com/cssref/"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://developer.mozilla.org/en-US/docs/Web/CSS/Reference"<CR>

nnoremap <buffer> \\v :Validate<CR>

" adapted from https://stackoverflow.com/a/22865673
" FIXME this doesn't produce good output;
"nnoremap <buffer> \\= :%s/[{;}]/&\r/g<CR>gg=G
" TODO create a mapping for visual mode (for selected range formatting)
