""" ----------------------------------------
""" Objective C++-specific vim configuration
""" ----------------------------------------

runtime! sergebass/sergebass-gdb.vim

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" for some reason vim-commentary uses /* */ C-style commenting, but let's use // instead
setlocal commentstring=//\ %s

" Only use valid C++ identifier characters
setlocal iskeyword=@,48-57,_

" we need that comment mark at the end since this on-hover function does not accept arguments but uses the word under cursor
setlocal keywordprg=:call\ LanguageClient#textDocument_hover()\ \"

nmap <buffer> <Space>mhh K

" do our formatting using clang-format and the '=' command
setlocal equalprg=clang-format

function! SwitchObjCppSourceHeader()
  if (expand ("%:e") == "mm")
    return expand("%:t:r") . ".h"
  else
    return expand("%:t:r") . ".mm"
  endif
endfunction

" toggle between source and header
" SPC m g a     open matching file (e.g. switch between .mm and .h)
nmap <buffer> <Space>mga :call LanguageClient#textDocument_switchSourceHeader()<CR>
" SPC m g A     open matching file in another window (e.g. switch between .mm and .h)
nmap <buffer> <Space>mgA :vsplit <bar> call LanguageClient#textDocument_switchSourceHeader()<CR>

" alternative method for switching between sources and headers
nmap <buffer> \\` :find <C-r>=SwitchObjCppSourceHeader()<CR><CR>
nmap <buffer> \\~ :vert sfind <C-r>=SwitchObjCppSourceHeader()<CR><CR>

" Add highlighting for function definition in C++ (adapted from vim.fandom.com)
highlight CppMethodDefinition term=inverse cterm=inverse gui=inverse
function! EnhanceCppSyntax()
  syntax match cppMethodDefinition "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  highlight default link cppMethodDefinition CppMethodDefinition
endfunction

autocmd Syntax cpp call EnhanceCppSyntax()

" jump to next/previous method definition (adapted from vim.fandom.com)
nnoremap <silent> <C-j> /\v^(\w+\s+)?\w+::\w+\(.*\)<CR>
nnoremap <silent> <C-k> ?\v^(\w+\s+)?\w+::\w+\(.*\)<CR>

" nnoremap <buffer> \\<F1> :!sp-open "https://en.cppreference.com/w/cpp"<CR>

" " search the word under cursor in cppreference.com reference (using browser)
" nnoremap <buffer> \\?1 :!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\?1 "*y<Esc>:!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" " search the word under cursor in cplusplus.com reference (using browser)
" nnoremap <buffer> \\?2 :!sp-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
" vnoremap <buffer> \\?2 "*y<Esc>:!sp-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

nnoremap <buffer> <CR> :call LanguageClient#textDocument_definition()<CR>
nmap <buffer> <Space>mgg <CR>

nnoremap <buffer> <Space>mrr :call LanguageClient#textDocument_rename()<CR>

nnoremap <buffer> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <buffer> gO :call LanguageClient#textDocument_documentSymbol()<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific Objective C++ settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-objcpp.vim"))
    source ~/.workspace-objcpp.vim
endif
