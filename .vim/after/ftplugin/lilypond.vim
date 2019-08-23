""" -------------------------------
""" LILYPOND-SPECIFIC CONFIGURATION
""" -------------------------------

" I don't like tabs, use spaces throughout
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" TODO find a command line utility to query Lilypond manuals
"setlocal keywordprg=hoogle

nnoremap <buffer> <F1> :!xdg-open "http://lilypond.org/doc/v2.18/Documentation/notation/index.html"<CR>

" search the word under cursor in Lilypond manuals (using browser)
nnoremap <buffer> \\? :!xdg-open "https://duckduckgo.com/?q=site:lilypond.org/doc/ <C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\? "*y<Esc>:!xdg-open "https://duckduckgo.com/?q=site:lilypond.org/doc/ <C-r>*"<Left>
