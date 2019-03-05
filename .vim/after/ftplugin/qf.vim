" augment/override QuickFix window handling

setlocal wrap
setlocal statusline=%t%{exists('w:quickfix_title')?'\ '.w:quickfix_title:''}%=%l:\ %p%%/%L

" open selected line file in a new vertical split
nnoremap <silent> <buffer> <Leader><CR> <C-w><CR><C-w>H
" open selected line file in a new horizontal split
nnoremap <silent> <buffer> <Space><CR> <C-w><CR>
" open selected line file in a new tab
nnoremap <silent> <buffer> <BS><CR> <C-w><CR><C-w>T
