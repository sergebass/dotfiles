""" -------------------------------
""" C++-SPECIFIC CONFIGURATION
""" -------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

" for some reason vim-commentary uses /* */ C-style commenting, but let's use // instead
setlocal commentstring=//\ %s

" setlocal keywordprg=man
setlocal keywordprg=:LspHover

" nnoremap <buffer> K :LspHover<CR>
nmap <buffer> <CR>hh K

nnoremap <buffer> <F1> :!xdg-open "https://en.cppreference.com/w/cpp"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "http://www.cplusplus.com"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> \\?1 :!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?1 "*y<Esc>:!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> \\?2 :!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?2 "*y<Esc>:!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" toggle between source and header
nmap <buffer> <CR>ga :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>

nnoremap <buffer> <CR><CR> :LspDefinition<CR>
nmap <buffer> <CR>gg <CR><CR>

" SPC m g a 	open matching file (e.g. switch between .cpp and .h)
" SPC m g A 	open matching file in another window (e.g. switch between .cpp and .h)
" SPC m D 	disaster: disassemble c/c++ code

nnoremap <buffer> <CR>rr :LspRename<CR>
