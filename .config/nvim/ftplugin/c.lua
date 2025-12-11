----------------------------------
-- C-specific neovim configuration
----------------------------------

-- Default ftplugin for C++ sources this C-specific script as well.
-- We do not reuse C settings for C++ as a base, so abort right away.
if vim.bo.filetype ~= 'c' then
    return
end

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.autoindent = true

-- Do our formatting using clang-format and the '=' command
vim.opt_local.equalprg = "clang-format"

-- Jump to definition of the symbol under cursor
vim.keymap.set('n', '<CR>', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: Go to definition' })

-- TODO: refactor legacy keymaps to use Lua API instead of vim.cmd:
vim.cmd([[
  nnoremap <buffer> <F1> :!sp-open "https://en.cppreference.com/w/c"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "http://www.cplusplus.com/reference/clibrary/"<CR>

  " search the word under cursor in cppreference.com reference (using browser)
  nnoremap <buffer> \\?1 :!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\?1 "*y<Esc>:!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

  " search the word under cursor in cplusplus.com reference (using browser)
  nnoremap <buffer> \\?2 :!sp-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\?2 "*y<Esc>:!sp-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

  " -----------------------------------------------------------------------------
  " Apply workspace-specific C settings, if available;
  " this is placed at the end to make sure workspace configuration takes priority
  " and possibly overrides our stock mappings (including the above)
  " -----------------------------------------------------------------------------

  if filereadable(expand("~/.workspace-c.vim"))
      source ~/.workspace-c.vim
  endif

  if filereadable(expand("~/.workspace-c.lua"))
      source ~/.workspace-c.lua
  endif
]])
