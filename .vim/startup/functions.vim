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
function LocateFiles(file_pattern)
  let error_file = tempname()
  silent exe '!locate "' . a:file_pattern . '" | xargs file > ' . error_file
  set errorformat=%f:%m
  exe "cfile " . error_file
  copen
  call delete(error_file)
endfunction

" Find files under current directory (as found by find)
" and populate the quickfix list (based on https://vim.fandom.com/wiki/Searching_for_files)
function FindFiles(file_pattern)
  let error_file = tempname()
  " silent exe '!find . -name "' . a:file_pattern . '" | xargs file | sed "s/:/:1:/" > ' . error_file
  " set errorformat=%f:%l:%m
  silent exe '!find . -name "' . a:file_pattern . '" | xargs file > ' . error_file
  set errorformat=%f:%m
  exe "cfile " . error_file
  copen
  call delete(error_file)
endfunction

function FindText(searcher_with_args, text, file_pattern)
    let find_command = a:searcher_with_args . ' ' . a:text . ' ' . a:file_pattern . ' | cw'
    execute l:find_command
    " FIXME handle errors
endfunction

function FindAndReplaceText(searcher_with_args, old_text, new_text, file_pattern)
    let find_command = a:searcher_with_args . ' ' . a:old_text . ' ' . a:file_pattern . ' | cw'
    execute l:find_command
    " FIXME handle errors
    let replace_command = 'cfdo %s/' . a:old_text . '/' . a:new_text . '/gc | cclose'
    execute l:replace_command
endfunction

function SPTabLine()
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

function SPFindFileWithLine(file_with_line)
    let parts = split(a:file_with_line, ':')
    if len(parts) == 1  " just the file name is present
        execute 'find' parts[0]
    elseif len(parts) == 2  " filename:line
        execute 'find' ('+' . parts[1]) parts[0]
    elseif len(parts) == 3  " filename:line:column
        execute 'find' ('+' . parts[1]) parts[0]
        execute 'normal! ' . parts[2] . '|'
    else
        echoe "Invalid argument"
    endif
endfunction

function SPVentilatedFormatExpr()
    let startLine = v:lnum
    let endLine = v:lnum + v:count - 1

    " First, join all selected lines together
    execute startLine . ',' . endLine . 'join'

    " And now automatically insert linebreaks after period and exclamation/question signs
    execute startLine . ',' . endLine . 's/[.!?]\zs /\r/g'

    " Since the size of the adjusted paragraph may have changed,
    " jump to the beginning of the modifications.
    execute 'normal! ' . startLine . 'gg'
endfunction
