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

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
" nnoremap <buffer> <F1> :!xdg-open "https://haskell.org/hoogle/"<CR>
" nnoremap <buffer> <M-F1> :!xdg-open "https://www.stackage.org"<CR>

" " search the word under cursor in Hoogle database (using browser)
" nnoremap <buffer> \\? :!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

nnoremap <buffer> <CR> :call LanguageClient#textDocument_definition()<CR>
nmap <buffer> <Space>mgg <CR>

nnoremap <buffer> <Space>mrr :call LanguageClient#textDocument_rename()<CR>

nnoremap <buffer> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> gO :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <buffer> <C-N> :call LanguageClient#textDocument_documentSymbol()<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific Rust settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-rust.vim"))
    source ~/.workspace-rust.vim
endif
