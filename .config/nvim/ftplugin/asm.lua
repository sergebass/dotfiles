-----------------------------------------
-- Assembly-specific neovim configuration
-----------------------------------------

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.autoindent = true

-- Jump to definition of the symbol under cursor
-- vim.keymap.set('n', '<CR>', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: Go to definition' })
vim.keymap.set('n', '<CR>', require('telescope.builtin').lsp_definitions, { buffer = true, desc = 'Telescope: LSP: Go to definition (telescope)' })

vim.cmd([[
  nnoremap <buffer> <F1> :!sp-open "https://www.felixcloutier.com/x86/"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "https://arm.jonpalmisc.com/"<CR>

  " " search the word under cursor in Hoogle database (using browser)
  " nnoremap <buffer> \\? :!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>=expand("<cword>")<CR>"<Left>
  " vnoremap <buffer> \\? "*y<Esc>:!sp-open "https://www.haskell.org/hoogle/?hoogle=<C-r>*"<Left>

  " nnoremap <buffer> <CR> :call LanguageClient#textDocument_definition()<CR>
  " nmap <buffer> <Space>mgg <CR>

  " nnoremap <buffer> <Space>mrr :call LanguageClient#textDocument_rename()<CR>

  " nnoremap <buffer> K :call LanguageClient#textDocument_hover()<CR>
  " nnoremap <buffer> gd :call LanguageClient#textDocument_definition()<CR>
  " nnoremap <buffer> gO :call LanguageClient#textDocument_documentSymbol()<CR>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific Assembly settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-asm.vim"))
      source ~/.workspace-asm.vim
  endif

  if filereadable(expand("~/.workspace-asm.lua"))
      source ~/.workspace-asm.lua
  endif
]])
