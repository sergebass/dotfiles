-- Syntax rules that must be the last to be evaluated (i.e. assume the highest priority)

vim.cmd([[
  hi SPErrorMarker term=reverse cterm=bold ctermfg=226 ctermbg=88 gui=bold guifg=#ffff00 guibg=#870000
  hi SPWarningMarker term=reverse cterm=bold ctermfg=226 ctermbg=69 gui=bold guifg=#ffff00 guibg=#5f87ff
  " TODO: implement SPInfoMarker, move TODO, NB, NOTE to this new highlight group

  " We need this to enable proper highlight handling with multiple splits (https://vi.stackexchange.com/a/7294)
  augroup SPCustomHighlighting
      autocmd!
      autocmd VimEnter,WinEnter * call matchadd('SPErrorMarker', '\<\(FIXME\|BUG\|XXX\|ASAP\|URGENT\|ERROR\|FAILURE\|FAILED\)\>\|!!!\|???\|<<<<<<<\|>>>>>>>')
      autocmd VimEnter,WinEnter * call matchadd('SPWarningMarker', '\<\(TODO\|NB\|NOTE\|Note\|WARNING\|Warning\|CAUTION\|ATTENTION\)\>\|=======\||||||||')
  augroup END
]])
