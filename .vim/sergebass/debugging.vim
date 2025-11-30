" Debugging configuration for Vim and Neovim

" Multi-language debugger support
if has('python3')
    Plug 'puremourning/vimspector'
else
    echo "Warning: vimspector requires python3 support in Vim, skipping plugin"
endif

let g:vimspector_base_dir='~/.nvim-plugins/vimspector'
