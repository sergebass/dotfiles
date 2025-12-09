-- Lua module for Neovim debugging configuration

local dap = require('dap')

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/absolute/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/run/current-system/sw/bin/lldb-dap', -- must be absolute path; /usr/bin/lldb-vscode in FHS Linux
  name = 'lldb'
}

-- NOTE this requires gdb 14+
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.configurations.cpp = {
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process",
    type = 'cpp',  -- FIXME ? Adjust this to match your adapter name (`dap.adapters.<name>`)
    request = 'attach',
    pid = require('dap.utils').pick_process,
    args = {},
  },
  {
    name = 'Launch lldb-vscode',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    -- lldb-vscode by default doesn't inherit the environment variables from the parent.
    env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          table.insert(variables, string.format("%s=%s", k, v))
        end
        return variables
    end,
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
    name = "Launch gdb",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
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

-- FIXME move to shortcuts
-- Setting breakpoints via :lua require'dap'.toggle_breakpoint().
-- Launching debug sessions and resuming execution via :lua require'dap'.continue().
-- Stepping through code via :lua require'dap'.step_over() and :lua require'dap'.step_into().
-- Inspecting the state via the built-in REPL: :lua require'dap'.repl.open() or using the widget UI (:help dap-widgets)

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

vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)

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

  " nmap <Space>dc :DapContinue<CR>
  " nmap <M-.> :DapContinue<CR>

  " nmap <Space>ds :DapStepOver<CR>
  " nmap <M-;> :DapStepOver<CR>

  "nmap <Space>di :DapStepInto<CR>
  "nmap <M-'> :DapStepInto<CR>

  " nmap <Space>do :DapStepOut<CR>
  " nmap <M-,> :DapStepOut<CR>

  nmap <Space>dr :DapRestartFrame<CR>

  nmap <Space>dIt :DapEval<CR>
  " nmap <Space>dv :DapEval<CR>
  " nmap <M-=> :DapEval<CR>
  nmap <RightMouse> :DapEval<CR>

  " nmap <Space>dbb :DapToggleBreakpoint<CR>
  " nmap <Space>dba :VimspectorAddFunctionBreakpoint<CR>
  " nmap <Space>dwb :VimspectorBreakpoints<CR>
  nmap <Space>dbD :DapClearBreakpoints<CR>

  nmap <Space>d'_ :DapToggleRepl<CR>
]])
