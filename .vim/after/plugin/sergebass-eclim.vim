""" --------------------------
""" General settings for eclim
""" --------------------------

let g:EclimLocateFileScope = 'workspace'
let g:EclimLocateFileDefaultAction = 'edit'
let g:EclimLocateFileNonProjectScope = 'ag'
let g:EclimJavaCallHierarchyDefaultAction = 'edit'
let g:EclimJavaHierarchyDefaultAction = 'edit'

nnoremap <LocalLeader><M-BS> :LocateFile<CR>

nnoremap <LocalLeader><Space> :BuffersToggle<CR>

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
