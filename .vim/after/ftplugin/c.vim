""" -------------------------------
""" C-SPECIFIC CONFIGURATION
""" -------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

setlocal keywordprg=man

nnoremap <buffer> <F1> :!xdg-open "http://www.cplusplus.com/reference/clibrary/"<CR>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> <LocalLeader>? :!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> <LocalLeader>? "*y<Esc>:!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" toggle between source and header
nnoremap <buffer> <F4> ::e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
