""" -------------------------------------
""" Typescript-specific vim configuration
""" -------------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal keywordprg=stack\ hoogle\ --\ --count=100
setlocal makeprg=tsc

" setlocal omnifunc=javascriptcomplete#CompleteJS

nnoremap <buffer> <F1> :!sp-open "https://www.typescriptlang.org/docs/home.html"<CR>
nnoremap <buffer> <M-F1> :!sp-open "https://dev.w3.org/html5/html-author/"<CR>

" search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

" shortcuts for language client/server use
nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
nmap <buffer> <Space>mhh K

nnoremap <buffer> <silent> <CR><CR> :call LanguageClient#textDocument_definition()<CR>
" SPC m g g 	jump to entity's definition
nmap <buffer> <Space>mgg :call LanguageClient#textDocument_definition()<CR>

nnoremap <buffer> <silent> <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" SPC m = 	reformat the buffer
" SPC m g b 	jump back
" SPC m g t 	jump to entity's type definition
" SPC m g u 	references
" SPC m h h 	documentation at point
" SPC m r r 	rename symbol
" SPC m s p 	send selected region or current buffer to the web playground
" SPC m S r 	restart server

" -----------------------------------------------------------------------------
" Apply workspace-specific Typescript settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-typescript.vim"))
    source ~/.workspace-typescript.vim
endif
