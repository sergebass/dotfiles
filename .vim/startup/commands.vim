""" ---------------
""" CUSTOM COMMANDS
""" ---------------

command! ClearQuickfixList call ClearQuickfixList()

command! ClearLocationList call ClearLocationList()

command RemoveMultipleBlankLines %s/^\_s\+\n/\r/e
command RemoveRedundantWhitespace %s/\s\+$//e
