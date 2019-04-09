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
nmap <buffer> <CR>hh K

nnoremap <buffer> <silent> <CR><CR> :call LanguageClient#textDocument_definition()<CR>
nmap <buffer> <CR>gg :call LanguageClient#textDocument_definition()<CR>

nnoremap <buffer> <silent> <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" SPC m = 	reformat the buffer
" SPC m g b 	jump back
" SPC m g g 	jump to entity's definition
" SPC m g t 	jump to entity's type definition
" SPC m g u 	references
" SPC m h h 	documentation at point
" SPC m r r 	rename symbol
" SPC m s p 	send selected region or current buffer to the web playground
" SPC m S r 	restart server
