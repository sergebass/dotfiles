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
    let tab_number = i + 1

    let window_number = tabpagewinnr(tab_number)
    let window_count = tabpagewinnr(tab_number, '$')

    let buffers = tabpagebuflist(tab_number)
    let buffer_number = buffers[window_number - 1]
    let buffer_name = bufname(buffer_number)

    let is_buffer_modified = getbufvar(buffer_number, "&mod")

    let s .= '%' . tab_number . 'T'
    let s .= (tab_number == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

    let s .=  ' ' . tab_number . ':'

    let s .= (buffer_name != '' ? fnamemodify(buffer_name, ':t') : '--')

    if is_buffer_modified
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
