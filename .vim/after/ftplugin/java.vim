""" -------------------------------
""" Java-specific vim configuration
""" -------------------------------

" Java for Android is configured here by default; fix for desktop/server Java accordingly
"
" runtime sergebass/eclim-java.vim

nnoremap <buffer> \\<F1> :!sp-open "https://developer.android.com/reference"<CR>

" setlocal keywordprg=:JavaDocPreview

nnoremap <buffer> K :!sp-open "https://duckduckgo.com?q=<C-r>=expand("<cword>")<CR> android"<CR>
nmap <buffer> <Space>mhh K

" use ctags for Java on Android
nnoremap <buffer> <CR> g<C-]>
nmap <buffer> <Space>mgg <CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific Java settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-java.vim"))
    source ~/.workspace-java.vim
endif
