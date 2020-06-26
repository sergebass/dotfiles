""" ----------------
""" CUSTOM FUNCTIONS
""" ----------------

function ClearQuickfixList()
  call setqflist([])
endfunction

function ClearLocationList()
  call setloclist(0, [])
endfunction

" Find files anywhere (as tracked by locate)
" and populate the quickfix list (based on https://vim.fandom.com/wiki/Searching_for_files)
function! LocateFiles(file_pattern)
  let error_file = tempname()
  silent exe '!locate "' . a:file_pattern . '" | xargs file > ' . error_file
  set errorformat=%f:%m
  exe "cfile " . error_file
  copen
  call delete(error_file)
endfunction

" Find files under current directory (as found by find)
" and populate the quickfix list (based on https://vim.fandom.com/wiki/Searching_for_files)
function! FindFiles(file_pattern)
  let error_file = tempname()
  " silent exe '!find . -name "' . a:file_pattern . '" | xargs file | sed "s/:/:1:/" > ' . error_file
  " set errorformat=%f:%l:%m
  silent exe '!find . -name "' . a:file_pattern . '" | xargs file > ' . error_file
  set errorformat=%f:%m
  exe "cfile " . error_file
  copen
  call delete(error_file)
endfunction

function FindAndReplace(oldText, newText, filePattern)
    let findCommand = 'grep -w -s ' . a:oldText . ' ' . a:filePattern . ' | cw'
    execute l:findCommand
    " FIXME handle errors
    let replaceCommand = 'cfdo %s/' . a:oldText . '/' . a:newText . '/gc | cclose'
    execute l:replaceCommand
endfunction

function! SPTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .=  ' ' . tab . '.' . tabpagewinnr(tab) . (tab == tabpagenr() ? '*' : '') . ':'

    let s .= (bufname != '' ? fnamemodify(bufname, ':t') : '[-]')

    if bufmodified
      let s .= '!'
    endif

    let s .= ' '
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction
