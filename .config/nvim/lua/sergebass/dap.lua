-- Lua module for Neovim debugging configuration

local dap = require('dap')

-- NOTE: this requires gdb with DAP support (version 14+)
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",  -- Make sure it's on PATH
  -- Suppress gdb-dashboard when used from Neovim (but keep custom prettifiers)
  args = { "-i", "dap", "-ex", "dashboard -enabled off", }
}

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-dap',  -- Make sure it's on PATH
  name = 'lldb'
}

dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",  -- Make sure it's on PATH

    -- On windows you may have to uncomment this:
    -- detached = false,
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = 'OpenDebugAD7',  -- Make sure it's on PATH
}

-- FIXME: example taken from dap.txt; adapt to our Python setup
-- dap.adapters.debugpy = {
--   type = 'executable';
--   command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }

---------------------------
-- Basic DAP configurations
---------------------------

dap.configurations.cpp = {
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process (gdb)",
    type = 'gdb',  -- Make sure to match your adapter name (`dap.adapters.<name>`)
    request = 'attach',
    pid = require('dap.utils').pick_process,
    args = {},
  },
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process (lldb)",
    type = 'lldb',  -- Make sure to match your adapter name (`dap.adapters.<name>`)
    request = 'attach',
    pid = require('dap.utils').pick_process,
    args = {},
  },
  {
    name = "Launch gdb",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    -- TODO: ask for arguments?
    args = {},
    cwd = "${workspaceFolder}",
    -- stopAtBeginningOfMainSubprogram = true,
    -- stopOnEntry = true,
  },
  {
    name = 'Launch lldb-dap',
    type = 'lldb',  -- Make sure to match your adapter name (`dap.adapters.<name>`)
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    -- TODO: ask for arguments?
    args = {},
    -- lldb-vscode by default doesn't inherit the environment variables from the parent.
    env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          table.insert(variables, string.format("%s=%s", k, v))
        end
        return variables
    end,
    cwd = '${workspaceFolder}',
    -- stopAtBeginningOfMainSubprogram = true,
    -- stopOnEntry = true,

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
  {
    name = "Launch codelldb",
    type = "codelldb",  -- Make sure to match your adapter name (`dap.adapters.<name>`)
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    -- TODO: ask for arguments?
    args = {},
    cwd = "${workspaceFolder}",
    -- stopAtBeginningOfMainSubprogram = true,
    -- stopOnEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- You can get rust types by adding:
-- dap.configurations.rust = {
--   {
--     -- ... the previous config goes here ...,
--     initCommands = function()
--       -- Find out where to look for the pretty printer Python module
--       local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

--       local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
--       local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

--       local commands = {}
--       local file = io.open(commands_file, 'r')
--       if file then
--         for line in file:lines() do
--           table.insert(commands, line)
--         end
--         file:close()
--       end
--       table.insert(commands, 1, script_import)

--       return commands
--     end,
--     -- ...,
--   }
-- }

-- Configure DAP signs
-- Alternative Unicode characters: 🛑 ● →
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#000000', bg = '#bc7b25' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#000040', bg = '#b0bc25' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#000000', bg = '#bc25a1' })
vim.api.nvim_set_hl(0, 'DapLine', { ctermbg = 0, bg = '#202020' })

vim.fn.sign_define('DapBreakpoint', {text='B', texthl='DapBreakpoint', linehl='DapLine', numhl='DapBreakpoint'})
vim.fn.sign_define('DapBreakpointCondition', {text='C', texthl='DapBreakpoint', linehl='DapLine', numhl='DapBreakpoint'})
vim.fn.sign_define('DapBreakpointRejected', {text='R', texthl='DapBreakpoint', linehl='DapLine', numhl='DapBreakpoint'})
vim.fn.sign_define('DapLogPoint', {text='L', texthl='DapLogPoint', linehl='DapLine', numhl='DapLogPoint'})
vim.fn.sign_define('DapStopped', {text='→', texthl='DapStopped', linehl='DapLine', numhl='DapStopped'})

----------
-- Keymaps
----------

vim.keymap.set('n', '<Space>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<M-.>', function() require('dap').continue() end)

vim.keymap.set('n', '<Space>ds', function() require('dap').step_over() end)
vim.keymap.set('n', '<M-;>', function() require('dap').step_over() end)

vim.keymap.set('n', '<Space>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<M-\'>', function() require('dap').step_into() end)

vim.keymap.set('n', '<Space>do', function() require('dap').step_out() end)
vim.keymap.set('n', '<M-,>', function() require('dap').step_out() end)

vim.keymap.set('n', '<Space>dbb', function() require('dap').toggle_breakpoint() end)

vim.keymap.set('n', '<Space>dba', function() require('dap').set_breakpoint() end)

vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)

vim.keymap.set('n', '<Space>d\'_', function() require('dap').repl.open() end)

vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)

vim.keymap.set({'n', 'v'}, '<Space>dv', function()
  require('dap.ui.widgets').preview()
end)

vim.keymap.set({'n', 'v'}, '<M-=>', function()
  require('dap.ui.widgets').preview()
end)

vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)

vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

vim.cmd([[
  " Universal language debugger support (via DAP) using nvim-dap

  nmap <Space>ddd :DapNew<CR>
  " nmap <Space>ddd :DapPause<CR>
  nmap <Space>da :DapTerminate<CR>
  nmap <Space>dA :DapTerminate<CR>

  nmap <Space>dr :DapRestartFrame<CR>

  nmap <Space>dIt :DapEval<CR>
  nmap <RightMouse> :DapEval<CR>

  " nmap <Space>dwb :VimspectorBreakpoints<CR>
  nmap <Space>dbD :DapClearBreakpoints<CR>

  " Evaluate the word under the cursor, or if in visual mode, the currently highlighted text.
  nnoremap <M-v> <Cmd>lua require("dapui").eval()<CR>
  vnoremap <M-v> <Cmd>lua require("dapui").eval()<CR>
]])
