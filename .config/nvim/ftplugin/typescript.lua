-------------------------------------------
-- Typescript-specific neovim configuration
-------------------------------------------

vim.cmd([[
  setlocal expandtab
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal autoindent

  nnoremap <buffer> <F1> :!sp-open "https://html.spec.whatwg.org/dev"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://www.typescriptlang.org/docs"<CR>

  " search the word under cursor in Mozilla Developer Network documentation (using browser)
  nnoremap <buffer> \\? :!sp-open "https://developer.mozilla.org/en-US/search?q=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://developer.mozilla.org/en-US/search?q=<C-r>*"<Left>

  " -----------------------
  " Spacemacs-style keymaps
  " -----------------------

  " SPC m = or SPC m = = if using lsp backend     reformat the buffer
  " SPC m E d     add tslint:disable-next-line at point
  " SPC m E e     fix thing at point
  " SPC m g b     jump back
  " SPC m g g     jump to entity's definition
  " SPC m g t     jump to entity's type definition
  " SPC m g r     references
  " SPC m h h     documentation at point
  " SPC m p       send selected region or current buffer to the web playground
  " SPC m r i     organize imports
  " SPC m r r     rename symbol
  " SPC m r f     rename file
  " SPC m S r     restart server
  " SPC m S j     create a barebone jsconfig.json at project root

  " -----------------------------------------------------------------------------
  " Apply workspace-specific Typescript settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-typescript.vim"))
      source ~/.workspace-typescript.vim
  endif
]])
