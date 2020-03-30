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

" LanguageClient#textDocument_typeDefinition()
" LanguageClient#textDocument_implementation()
" LanguageClient#textDocument_codeAction()
" LanguageClient#textDocument_completion()
" LanguageClient#textDocument_formatting()
" LanguageClient#textDocument_rangeFormatting()
" LanguageClient#textDocument_documentHighlight()
" LanguageClient#clearDocumentHighlight()
" LanguageClient#workspace_symbol()
" LanguageClient#workspace_applyEdit()
" LanguageClient#workspace_()
" LanguageClient#workspace_()
