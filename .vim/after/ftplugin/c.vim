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

" NOTE that if you are using Plug mapping you should not use `noremap` mappings

" we need that comment mark at the end since this on-hover function does not accept arguments but uses the word under cursor
setlocal keywordprg=:call\ LanguageClient#textDocument_hover()\ \"

" setlocal omnifunc=ccomplete#Complete

nmap <buffer> <silent> K <Plug>(lcn-hover)

nmap <buffer> <silent> <CR> <Plug>(lcn-definition)

" do our formatting using clang-format and the '=' command
setlocal equalprg=clang-format

function! SwitchCSourceHeader()
  if (expand ("%:e") == "c")
    return expand("%:t:r") . ".h"
  else
    return expand("%:t:r") . ".c"
  endif
endfunction

" alternative method for switching between sources and headers
nmap <buffer> \\` :find <C-r>=SwitchCSourceHeader()<CR><CR>
nmap <buffer> \\~ :vert sfind <C-r>=SwitchCSourceHeader()<CR><CR>

nnoremap <buffer> <F1> :!sp-open "https://en.cppreference.com/w/c"<CR>
nnoremap <buffer> <M-F1> :!sp-open "http://www.cplusplus.com/reference/clibrary/"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> \\?1 :!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?1 "*y<Esc>:!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> \\?2 :!sp-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?2 "*y<Esc>:!sp-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" SPC m D   disaster: disassemble c/c++ code

" -----------------------------------------------------------------------------
" Apply workspace-specific C settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-c.vim"))
    source ~/.workspace-c.vim
endif
