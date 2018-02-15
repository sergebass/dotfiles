""" ----------------
""" CUSTOM FUNCTIONS
""" ----------------

function ClearQuickfixList()
  call setqflist([])
endfunction

function ClearLocationList()
  call setloclist(0, [])
endfunction
