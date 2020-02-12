""" ---------------------------------
""" RUBY-SPECIFIC CONFIGURATION
""" ---------------------------------

" I don't like tabs, use spaces throughout
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

setlocal keywordprg=ri

nnoremap <buffer> <F1> :!xdg-open "https://rubyapi.org/"<CR>

" search the word under cursor in the Ruby API database (using browser)
nnoremap <buffer> \\? :!xdg-open "https://rubyapi.org/2.7/o/s?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://rubyapi.org/2.7/o/s?q=<C-r>*"<Left>
