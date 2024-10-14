""" -------------------------------
""" VimL-specific vim configuration
""" -------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" -----------------------------------------------------------------------------
" Apply workspace-specific VimL settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-vim.vim"))
    source ~/.workspace-vim.vim
endif
