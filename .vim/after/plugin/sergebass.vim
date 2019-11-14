runtime! sergebass/sergebass-eclim.vim
runtime! sergebass/sergebass-mappings.vim
runtime! sergebass/sergebass-syntax.vim

" -----------------------------------------------------------------------------
" apply workspace-specific settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace.vim"))
    " workspace-specific settings that should not be tracked in this git repo
    source ~/.workspace.vim
endif

