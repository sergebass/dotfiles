""" -------------------------------
""" C++-SPECIFIC CONFIGURATION
""" -------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

setlocal keywordprg=man

nnoremap <buffer> <F1> :!xdg-open "https://en.cppreference.com/w/cpp"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "http://www.cplusplus.com"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> <LocalLeader>?1 :!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> <LocalLeader>?1 "*y<Esc>:!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> <LocalLeader>?2 :!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> <LocalLeader>?2 "*y<Esc>:!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" toggle between source and header
nnoremap <buffer> <F4> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
