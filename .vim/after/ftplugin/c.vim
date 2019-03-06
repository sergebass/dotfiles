""" -------------------------------
""" C-SPECIFIC CONFIGURATION
""" -------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

setlocal keywordprg=man

nnoremap <buffer> <F1> :!xdg-open "https://en.cppreference.com/w/c"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "http://www.cplusplus.com/reference/clibrary/"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> \\?1 :!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?1 "*y<Esc>:!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> \\?2 :!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?2 "*y<Esc>:!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" toggle between source and header
nnoremap <buffer> <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
