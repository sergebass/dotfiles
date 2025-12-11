------------------------------------
-- C++-specific neovim configuration
------------------------------------

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
  " Jump to next/previous method definition (adapted from vim.fandom.com)
  nnoremap <buffer> <silent> <C-j> /\v^(\w+\s+)?\w+::\w+\(.*\)<CR>
  nnoremap <buffer> <silent> <C-k> ?\v^(\w+\s+)?\w+::\w+\(.*\)<CR>

  nnoremap <buffer> <F1> :!sp-open "https://en.cppreference.com/w/cpp"<CR>
  nnoremap <buffer> <M-F1> :!sp-open "http://www.cplusplus.com/reference/"<CR>

  " Search the word under cursor in cppreference.com reference (using browser)
  nnoremap <buffer> \\?1 :!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\?1 "*y<Esc>:!sp-open "https://en.cppreference.com/mwiki/index.php?search=<C-r>*"<Left>

  " Search the word under cursor in cplusplus.com reference (using browser)
  nnoremap <buffer> \\?2 :!sp-open "http://www.cplusplus.com/search.do?q=<C-r>=expand("<cword>")<CR>"<Left>
  vnoremap <buffer> \\?2 "*y<Esc>:!sp-open "http://www.cplusplus.com/search.do?q=<C-r>*"<Left>

  " Key bindings from develop.spacemacs.org (FIXME: migrate to Lua API whatever is available/makes sense)
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

  if filereadable(expand("~/.workspace-cpp.lua"))
      source ~/.workspace-cpp.lua
  endif
]])
