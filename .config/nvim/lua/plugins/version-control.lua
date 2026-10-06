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
        init = function()
          vim.g.gitgutter_enabled = 1

          -- Highlight line numbers but not the lines themselves
          vim.g.gitgutter_highlight_linenrs = 1
          vim.g.gitgutter_highlight_lines = 0

           -- Show line numbers in gitgutter signs
          vim.g.gitgutter_sign_column_always = 1

          -- Pass this option to git diff (e.g. ignore whitespace)
          vim.g.gitgutter_diff_args = '-w'

          -- By default diffs are relative to index
          -- vim.g.gitgutter_diff_relative_to = 'working_tree'

          -- By default, diffs are against the index
          -- vim.g.gitgutter_diff_base = '<commit-SHA>'

           -- Update gitgutter every 1000ms
           vim.g.gitgutter_update_interval = 1000

           vim.cmd([[
             " Key mappings for gitgutter
             nmap <leader>gd :GitGutterDiffOrig<CR>
             nmap <leader>gh :GitGutterPreviewHunk<CR>
             nmap <leader>gs :GitGutterStageHunk<CR>
             nmap <leader>gu :GitGutterUndoHunk<CR>
             nmap <leader>gp :GitGutterPreviewHunk<CR>
             nmap <leader>gq :GitGutterQuickFixCurrentFile <Bar> copen <CR>
             nmap <leader>gQ :GitGutterQuickFix <Bar> copen <CR>
             nmap <leader>gz :GitGutterFold<CR>
           ]])
         end
     },
}
