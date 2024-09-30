""" ------------------------------
""" C++-specific vim configuration
""" ------------------------------

runtime! sergebass/sergebass-gdb.vim

" FIXME where do we place this?

let b:ale_linters = ['cc', 'clangd']

" FIXME ALE configuration for C++
let g:ale_cpp_cc_executable = 'g++-12'
let g:ale_cpp_cc_header_exts = ['h', 'hpp']
let g:ale_cpp_cc_options = '-std=c++23 -Wall'
let g:ale_cpp_cc_use_header_lang_flag = -1

let g:ale_cpp_ccls_executable = 'ccls'
let g:ale_cpp_ccls_init_options = {}

let g:ale_cpp_clangcheck_executable = 'clang-check'
let g:ale_cpp_clangcheck_options = ''

let g:ale_cpp_clangd_executable = 'clangd'
let g:ale_cpp_clangd_options = ''

let g:ale_cpp_clangtidy_checks = []
let g:ale_cpp_clangtidy_executable = 'clang-tidy'
let g:ale_cpp_clangtidy_extra_options = ''
let g:ale_cpp_clangtidy_options = ''

let g:ale_cpp_clazy_checks = ['level1']
let g:ale_cpp_clazy_executable = 'clazy-standalone'
let g:ale_cpp_clazy_options = ''

let g:ale_cpp_cppcheck_executable = 'cppcheck'
let g:ale_cpp_cppcheck_options = '--enable=style'

let g:ale_cpp_cpplint_executable = 'cpplint'
let g:ale_cpp_cpplint_options = ''

let g:ale_cpp_cquery_cache_directory = '/home/sergii/.cache/cquery'
let g:ale_cpp_cquery_executable = 'cquery'

let g:ale_cpp_flawfinder_executable = 'flawfinder'
let g:ale_cpp_flawfinder_minlevel = 1
let g:ale_cpp_flawfinder_options = ''

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" for some reason vim-commentary uses /* */ C-style commenting, but let's use // instead
setlocal commentstring=//\ %s

" Only use valid C++ identifier characters
setlocal iskeyword=@,48-57,_

" NOTE that if you are using Plug mapping you should not use `noremap` mappings

" we need that comment mark at the end since this on-hover function does not accept arguments but uses the word under cursor
" FIXME use LSPHover instead
" setlocal keywordprg=:call\ LanguageClient#textDocument_hover()\ \"

" nmap <buffer> <silent> K :LspHover<CR>
nmap <buffer> <silent> K \K

" nmap <buffer> <silent> <CR> :LspDefinition<CR>
nmap <buffer> <silent> <CR> \gd

" nmap <buffer> gd <plug>(lsp-definition)
" nmap <buffer> gs <plug>(lsp-document-symbol-search)
" nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
" nmap <buffer> gr <plug>(lsp-references)
" nmap <buffer> gi <plug>(lsp-implementation)
" nmap <buffer> gt <plug>(lsp-type-definition)
" nmap <buffer> <leader>rn <plug>(lsp-rename)
" nmap <buffer> [g <plug>(lsp-previous-diagnostic)
" nmap <buffer> ]g <plug>(lsp-next-diagnostic)
" nmap <buffer> K <plug>(lsp-hover)

" do our formatting using clang-format and the '=' command
setlocal equalprg=clang-format

function! SwitchCppSourceHeader()
  if (expand ("%:e") == "cpp")
    return expand("%:t:r") . ".h"
  else
    return expand("%:t:r") . ".cpp"
  endif
endfunction

" alternative method for switching between sources and headers
nmap <buffer> \\` :find <C-r>=SwitchCppSourceHeader()<CR><CR>
nmap <buffer> \\~ :vert sfind <C-r>=SwitchCppSourceHeader()<CR><CR>

" Add highlighting for function definition in C++ (adapted from vim.fandom.com)
highlight CppMethodDefinition term=inverse cterm=inverse gui=inverse
function! EnhanceCppSyntax()
  syntax match cppMethodDefinition "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  highlight default link cppMethodDefinition CppMethodDefinition
endfunction

autocmd Syntax cpp call EnhanceCppSyntax()

" jump to next/previous method definition (adapted from vim.fandom.com)
nnoremap <buffer> <silent> <C-j> /\v^(\w+\s+)?\w+::\w+\(.*\)<CR>
nnoremap <buffer> <silent> <C-k> ?\v^(\w+\s+)?\w+::\w+\(.*\)<CR>

nnoremap <buffer> \\<F1> :!sp-open "https://en.cppreference.com/w/cpp"<CR>

" search the word under cursor in cppreference.com reference (using browser)
nnoremap <buffer> \\?1 :!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?1 "*y<Esc>:!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

" search the word under cursor in cplusplus.com reference (using browser)
nnoremap <buffer> \\?2 :!sp-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
vnoremap <buffer> \\?2 "*y<Esc>:!sp-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

" SPC m D   disaster: disassemble c/c++ code

" LanguageClient#textDocument_typeDefinition()
" LanguageClient#textDocument_implementation()
" LanguageClient#textDocument_documentSymbol()
" LanguageClient#textDocument_references()
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

" Key bindings from develop.spacemacs.org
" ---------------------------------------
" 3 Key bindings
" Key binding   Description
" SPC m g a     open matching file
"       (e.g. switch between .cpp and .h, requires a project to work)
" SPC m g A     open matching file in another window
"       (e.g. switch between .cpp and .h, requires a project to work)
" SPC m D   disaster: disassemble c/c++ code
" SPC m r .     srefactor: refactor thing at point.
" SPC m r i     organize includes

" Note: semantic-refactor is only available for Emacs 24.4+.
"
" 3.1 Formatting (clang-format)
" Key binding   Description
" SPC m = =     format current region or buffer
" SPC m = f     format current function
"
" 3.2 RTags
" Key binding   Description
" SPC m g .     find symbol at point
" SPC m g ,     find references at point
" SPC m g ;     find file
" SPC m g /     find all references at point
" SPC m g [     location stack back
" SPC m g ]     location stack forward
" SPC m g >     c++ tags find symbol
" SPC m g <     c++ tags find references
" SPC m g B     show rtags buffer
" SPC m g d     print dependencies
" SPC m g D     diagnostics
" SPC m g e     reparse file
" SPC m g E     preprocess file
" SPC m g F     fixit
" SPC m g G     guess function at point
" SPC m g h     print class hierarchy
" SPC m g I     c++ tags imenu
" SPC m g L     copy and print current location
" SPC m g M     symbol info
" SPC m g O     goto offset
" SPC m g p     set current project
" SPC m g R     rename symbol
" SPC m g s     print source arguments
" SPC m g S     display summary
" SPC m g T     taglist
" SPC m g v     find virtuals at point
" SPC m g V     print enum value at point
" SPC m g X     fix fixit at point
" SPC m g Y     cycle overlays on screen
"
" 3.3 cquery / ccls

" The key bindings listed below are in addition to the default key bindings defined by the LSP layer. A [ccls] or [cquery] suffix indicates that the binding is for the indicated backend only.
"
" 3.3.1 backend (language server)
" Key binding   Description
" SPC m b f     refresh index (e.g. after branch change)
" SPC m b p     preprocess file
"
" 3.3.2 goto
" Key binding   Description
" SPC m g &     find references (address)
" SPC m g R     find references (read)
" SPC m g W     find references (write)
" SPC m g c     find callers
" SPC m g C     find callees
" SPC m g v     vars
" SPC m g f     find file at point (ffap)
" SPC m g F     ffap other window

"     goto/hierarchy
"     Key binding   Description
"     SPC m g h b   base class(es)
"     SPC m g h d   derived class(es) [ccls]
"     SPC m g h c   call hierarchy
"     SPC m g h C   call hierarchy (inv)
"     SPC m g h i   inheritance hierarchy
"     SPC m g h I   inheritance hierarchy (inv)
"     goto/member
"     Key binding   Description
"     SPC m g m h   member hierarchy
"     SPC m g m t   member types [ccls]
"     SPC m g m f   member functions [ccls]
"     SPC m g m v   member variables [ccls]

" -----------------------------------------------------------------------------
" Apply workspace-specific C++ settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-cpp.vim"))
    source ~/.workspace-cpp.vim
endif
