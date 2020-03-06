""" ----------------
""" CUSTOM FUNCTIONS
""" ----------------

function ClearQuickfixList()
  call setqflist([])
endfunction

function ClearLocationList()
  call setloclist(0, [])
endfunction

function FindAndReplace(oldText, newText, filePattern)
    let findCommand = 'grep -w -s ' . a:oldText . ' ' . a:filePattern . ' | cw'
    execute l:findCommand
    " FIXME handle errors
    let replaceCommand = 'cfdo %s/' . a:oldText . '/' . a:newText . '/gc | cclose'
    execute l:replaceCommand
endfunction
