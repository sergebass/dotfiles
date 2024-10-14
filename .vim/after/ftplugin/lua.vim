""" ------------------------------
""" Lua-specific vim configuration
""" ------------------------------

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal autoindent

" -----------------------------------------------------------------------------
" Apply workspace-specific Lua settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-lua.vim"))
    source ~/.workspace-lua.vim
endif
