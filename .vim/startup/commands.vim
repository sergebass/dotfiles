""" ---------------
""" CUSTOM COMMANDS
""" ---------------

command! ClearQuickfixList call ClearQuickfixList()
command! ClearLocationList call ClearLocationList()

command RemoveAllMultipleBlankLines %s/^\_s\+\n/\r/e
command RemoveSelectedMultipleBlankLines '<,'>s/^\_s\+\n/\r/e

command RemoveAllRedundantWhitespace %s/\s\+$//e
command RemoveSelectedRedundantWhitespace '<,'>s/\s\+$//e
