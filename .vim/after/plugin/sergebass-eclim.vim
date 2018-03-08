""" --------------------------
""" General settings for eclim
""" --------------------------

" FIXME make this stuff conditional, the eclim plugin may not be installed

let g:EclimLocateFileScope = 'workspace'
let g:EclimLocateFileDefaultAction = 'edit'
let g:EclimLocateFileNonProjectScope = 'ag'
let g:EclimJavaCallHierarchyDefaultAction = 'edit'
let g:EclimJavaHierarchyDefaultAction = 'edit'

nnoremap <LocalLeader><CR> :LocateFile<CR>

nnoremap <LocalLeader><Space> :Buffers<CR>

nnoremap <LocalLeader><Tab> :ProjectTree<CR>
nnoremap <LocalLeader><S-Tab> :ProjectsTree<CR>

nnoremap <LocalLeader>! :ProjectProblems!<CR>
nnoremap <LocalLeader>!! :ProjectProblems<CR>

nnoremap <LocalLeader>ptd :ProjectTodo<CR>
nnoremap <LocalLeader>pr :ProjectRefreshAll<CR>

nnoremap <LocalLeader>ac :Ant clean<CR>
nnoremap <LocalLeader>ab :Ant build<CR>
nnoremap <LocalLeader>at :Ant test<CR>

nnoremap <LocalLeader>v :Validate<CR>
