""" -----------------------------------
""" Assembly-specific vim configuration
""" -----------------------------------

runtime sergebass/gdb.vim

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" setlocal makeprg=cargo
" setlocal keywordprg=stack\ hoogle\ --\ --count=100

" nnoremap <buffer> <F1> :!sp-open "https://haskell.org/hoogle/"<CR>
" nnoremap <buffer> <M-F1> :!sp-open "https://www.stackage.org"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

" nnoremap <buffer> <CR> :call LanguageClient#textDocument_definition()<CR>
" nmap <buffer> <Space>mgg <CR>

" nnoremap <buffer> <Space>mrr :call LanguageClient#textDocument_rename()<CR>

" nnoremap <buffer> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <buffer> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <buffer> gO :call LanguageClient#textDocument_documentSymbol()<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific Assembly settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-asm.vim"))
    source ~/.workspace-asm.vim
endif
