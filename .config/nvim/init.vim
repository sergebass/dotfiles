if has("win32")
    set guifont=Ubuntu\ Mono:h10
else " Linux/Unix/OSX configuration
    set guifont=Inconsolata:h10
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
