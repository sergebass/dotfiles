""" -------------------------------
""" Rust-specific vim configuration
""" -------------------------------

runtime! sergebass/sergebass-gdb.vim

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

nmap <buffer> <silent> K <Plug>(lcn-hover)

nmap <buffer> <silent> <CR> <Plug>(lcn-definition)

" -----------------------------------------------------------------------------
" Apply workspace-specific Rust settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-rust.vim"))
    source ~/.workspace-rust.vim
endif
