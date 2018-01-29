" Late-stage QuickFix window handling

setlocal wrap

" make <Leader><CR> in quickfix windows open files in new tabs
nnoremap <silent> <buffer> <Leader><CR> <C-w><CR><C-w>T
