" Just reuse our existing vim configuration
" NOTE: do not forget to create a symlink in Windows; run in cmd with elevated privileges:
"
" C:\Users\sergiiperynskyi\AppData\Local>mklink /D nvim C:\Users\sergiiperynskyi\dotfiles\.config\nvim

" Reuse our classic Vim configuration for NeoVim as well
if has("win32")
    set runtimepath^=~/vimfiles runtimepath+=~/vimfiles/after
    let &packpath = &runtimepath
    source ~/vimfiles/vimrc
else " Linux/Unix/OSX configuration
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vim/vimrc
endif

" load our Neovim-specific Lua configuration to finalize our setup
lua require('vimrc')
