""" ---------------------------------
""" TYPESCRIPT-SPECIFIC CONFIGURATION
""" ---------------------------------

" I don't like tabs, use spaces throughout
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
setlocal makeprg=tsc

nnoremap <buffer> <F1> :!xdg-open "https://www.typescriptlang.org/docs/home.html"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "https://dev.w3.org/html5/html-author/"<CR>

" search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

" shortcuts for language client/server use
nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer> <silent> <CR> :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> <silent> <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
