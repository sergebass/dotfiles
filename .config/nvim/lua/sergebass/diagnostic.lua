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
vim.diagnostic.config({
  loclist = {
    open = true,
    severity = { min = vim.diagnostic.severity.WARN },
  }
})
