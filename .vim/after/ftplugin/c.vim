""" ----------------------------
""" C-specific vim configuration
""" ----------------------------

runtime! sergebass/sergebass-gdb.vim

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" use // for commenting with vim-commentary (C99+ supports them)
setlocal commentstring=//\ %s

" Only use valid C identifier characters
setlocal iskeyword=@,48-57,_

" we need that comment mark at the end since this on-hover function does not accept arguments but uses the word under cursor
setlocal keywordprg=:call\ LanguageClient#textDocument_hover()\ \"

nmap <buffer> <Space>mhh K

" do our formatting using clang-format and the '=' command
setlocal equalprg=clang-format

function! SwitchSourceHeader()
  if (expand ("%:e") == "c")
    return expand("%:t:r") . ".h"
  else
    return expand("%:t:r") . ".c"
  endif
endfunction

" toggle between source and header
" SPC m g a     open matching file (e.g. switch between .c and .h)
nmap <buffer> <Space>mga :find <C-r>=SwitchSourceHeader()<CR><CR>
" SPC m g A     open matching file in another window (e.g. switch between .c and .h)
nmap <buffer> <Space>mgA :vert sfind <C-r>=SwitchSourceHeader()<CR><CR>

" quicker shortcuts for source-header toggle
nmap <buffer> \\` <Space>mga
nmap <buffer> \\~ <Space>mgA

" FIXME make OS-agnostic (xdg-open is not available on Mac or Windows)
nnoremap <buffer> <F1> :!xdg-open "https://en.cppreference.com/w/c"<CR>
nnoremap <buffer> <M-F1> :!xdg-open "http://www.cplusplus.com/reference/clibrary/"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> \\?1 :!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?1 "*y<Esc>:!xdg-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> \\?2 :!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?2 "*y<Esc>:!xdg-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

nnoremap <buffer> <CR> :call LanguageClient#textDocument_definition()<CR>
nmap <buffer> <Space>mgg <CR>

" SPC m D   disaster: disassemble c/c++ code

nnoremap <buffer> <Space>mrr :call LanguageClient#textDocument_rename()<CR>

nnoremap <buffer> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> gO :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <buffer> <C-N> :call LanguageClient#textDocument_documentSymbol()<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific C settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-c.vim"))
    source ~/.workspace-c.vim
endif
