-- Version control related plugins for Neovim
return {
    -- fugitive.vim: A Git wrapper so awesome, it should be illegal
    { 'tpope/vim-fugitive' },

    -- rhubarb.vim: GitHub extension for fugitive.vim
    { 'tpope/vim-rhubarb' },

    -- A git commit browser
    { 'junegunn/gv.vim' },

    -- A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
    {
        'airblade/vim-gitgutter',
        config = function()
            vim.cmd([[
                " Enable gitgutter
                let g:gitgutter_enabled = 1

                " git gutter: pass this option to git diff
                let g:gitgutter_diff_args = '-w'

                " Update gitgutter every 1000ms
                let g:gitgutter_update_interval = 1000

                " Show line numbers in gitgutter signs
                let g:gitgutter_sign_column_always = 1

                " Use a minimal set of signs
                let g:gitgutter_sign_added = '│'
                let g:gitgutter_sign_modified = '│'
                let g:gitgutter_sign_removed = '‾'

                " Key mappings for gitgutter
                nmap <leader>gh :GitGutterPreviewHunk<CR>
                nmap <leader>gs :GitGutterStageHunk<CR>
                nmap <leader>gu :GitGutterUndoHunk<CR>
                nmap <leader>gp :GitGutterPreviewHunk<CR>
            ]])
        end
        },
}
