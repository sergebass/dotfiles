""" ------------------------------
""" Nix-specific vim configuration
""" ------------------------------

setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal autoindent
setlocal wrap
setlocal linebreak

nnoremap <buffer> <F1> :!sp-open "https://nix.dev/manual/nix/stable/language/index.html"<CR>
nnoremap <buffer> <M-F1> :!sp-open "https://search.nixos.org/options"<CR>
nnoremap <buffer> <S-F1> :!sp-open "https://nixos.wiki/wiki/Overview_of_the_Nix_Language"<CR>

" -----------------------------------------------------------------------------
" Apply workspace-specific Nix settings, if available;
" this is placed at the end to make sure workspace configuration takes priority
" and possibly overrides our stock mappings (including the above)
" -----------------------------------------------------------------------------

if filereadable(expand("~/.workspace-nix.vim"))
    source ~/.workspace-nix.vim
endif
