-- Neovim configuration for diagnostic stuff

-- Copy diagnostics to location list, but don't open it automatically (from neovim manual)
vim.diagnostic.handlers.loclist = {
  show = function(_, _, _, opts)
    -- Generally don't want it to open on every update
    opts.loclist.open = opts.loclist.open or false
    local winid = vim.api.nvim_get_current_win()
    vim.diagnostic.setloclist(opts.loclist)
    vim.api.nvim_set_current_win(winid)
  end
}

-- Open the location list on every diagnostic change (warnings/errors only).
-- vim.diagnostic.config({
--   loclist = {
--     open = true,
--     severity = { min = vim.diagnostic.severity.WARN },
--   }
-- })

vim.keymap.set('n', '\\dt', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.keymap.set('n', '\\de', vim.diagnostic.open_float, { desc = 'Explain diagnostic (in a pop-up)' })
vim.keymap.set('n', '\\dq', vim.diagnostic.setqflist, { desc = 'Copy diagnostics to quickfix window' })
