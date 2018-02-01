" error format for ant/javac
setlocal efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

""" ---------------------------------
""" MODE-SPECIFIC CONFIGURATION: JAVA
""" ---------------------------------

nnoremap <buffer> <LocalLeader><CR> :JavaSearchContext -a edit<CR>

nnoremap <buffer> <LocalLeader>ff :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x all -s all -t all
nnoremap <buffer> <LocalLeader>fd :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x declarations -s all -t all
nnoremap <buffer> <LocalLeader>fi :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x implementors -s all -t all
nnoremap <buffer> <LocalLeader>fr :JavaSearch -p <C-r>=expand("<cword>")<CR> -a edit -x references -s all -t all

nnoremap <buffer> <LocalLeader>^ :JavaHierarchy<CR>

nnoremap <buffer> <LocalLeader>< :JavaCallHierarchy<CR>
nnoremap <buffer> <LocalLeader>> :JavaCallHierarchy!<CR>

nnoremap <buffer> <LocalLeader>? :JavaDocPreview<CR>

nnoremap <buffer> <LocalLeader>d :JavaDocComment<CR>

nnoremap <buffer> <LocalLeader>n :JavaNew<Space>
nnoremap <buffer> <LocalLeader>nc :JavaConstructor
nnoremap <buffer> <LocalLeader>g :JavaGet
nnoremap <buffer> <LocalLeader>r :JavaRename<Space>
nnoremap <buffer> <LocalLeader>z :JavaImpl

nnoremap <buffer> <LocalLeader>t :JUnit %

nnoremap <buffer> <LocalLeader>1 :JavaCorrect<CR>

nnoremap <buffer> <LocalLeader>i :JavaImportOrganize<CR>
