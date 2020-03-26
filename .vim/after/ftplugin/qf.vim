" augment/override QuickFix window handling

setlocal wrap
setlocal statusline=%t%{exists('w:quickfix_title')?'\ '.w:quickfix_title:''}%=%l:\ %p%%/%L

" open selected line file in a new vertical split
nnoremap <silent> <buffer> \\v <C-w><CR><C-w>H:copen<CR>
" open selected line file in a new horizontal split
nnoremap <silent> <buffer> \\s <C-w><CR>
" open selected line file in a new tab
nnoremap <silent> <buffer> \\t <C-w><CR><C-w>T
