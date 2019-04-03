""" --------------------------
""" General settings for eclim
""" --------------------------

let g:EclimLocateFileScope = 'workspace'
let g:EclimLocateFileDefaultAction = 'edit'
let g:EclimLocateFileNonProjectScope = 'ag'
let g:EclimJavaCallHierarchyDefaultAction = 'edit'
let g:EclimJavaHierarchyDefaultAction = 'edit'

nnoremap \\ff :LocateFile<CR>

nnoremap \\bb :BuffersToggle<CR>

nnoremap <CR><Tab> :ProjectTree<CR>
nnoremap <CR><M-Tab> :ProjectsTree<CR>

nnoremap \\! :ProjectProblems!<CR>
nnoremap \\!! :ProjectProblems<CR>

nnoremap \\pt :ProjectTodo<CR>
nnoremap \\pr :ProjectRefreshAll<CR>

nnoremap \\ac :Ant clean<CR>
nnoremap \\ab :Ant build<CR>
nnoremap \\at :Ant test<CR>

nnoremap \\v :Validate<CR>
