""" ---------------
""" CUSTOM COMMANDS
""" ---------------

command! ClearQuickfixList call ClearQuickfixList()
command! ClearLocationList call ClearLocationList()

command RemoveAllMultipleBlankLines %s/^\_s\+\n/\r/e
command RemoveSelectedMultipleBlankLines '<,'>s/^\_s\+\n/\r/e

command RemoveAllRedundantWhitespace %s/\s\+$//e
command RemoveSelectedRedundantWhitespace '<,'>s/\s\+$//e

" Augment FZF's :Rg to enable preview (press '?' for display) and perform exact word search
command! -bang -nargs=* RgWords
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --word-regexp --case-sensitive '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Augment FZF's :Ag to enable preview (press '?' for display) and perform exact word search
command! -bang -nargs=* AgWords
  \ call fzf#vim#grep(
  \   'ag --nogroup --column --color --word-regexp --case-sensitive '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Augment FZF's :Rg to enable preview (press '?' for display) and perform identifier search (file type-specific)
" the file type is taken verbatim, provide custom remapping for types that do not match (e.g. 'javascript' -> 'js')
command! -bang -nargs=* RgId
  \ call fzf#vim#grep(
  \   'rg --type ' . &filetype . ' --column --line-number --no-heading --color=always --word-regexp --case-sensitive '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Augment FZF's :Ag to enable preview (press '?' for display) and perform identifier search (file type-specific)
" the file type is taken verbatim, provide custom remapping for types that do not match (e.g. 'javascript' -> 'js')
command! -bang -nargs=* AgId
  \ call fzf#vim#grep(
  \   'ag --' . &filetype . ' --nogroup --column --color --word-regexp --case-sensitive '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
