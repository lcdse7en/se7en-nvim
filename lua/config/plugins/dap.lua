return {
  {
    'mfussenegger/nvim-dap',
    lazy = false,
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      local map = vim.keymap.set

      vim.fn.sign_define('DapBreakpoint', { text = '🐞', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Keymap
      map('n', '<leader>bk', function()
        require('dap').toggle_breakpoint()
      end, { desc = 'Toggle Breakpoint' })

      map('n', '<leader>B', function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Set Breakpoint Condition' })

      map('n', '<F9>', function()
        require('dap').continue()
      end, { desc = 'Start Debbuging' })

      map('n', '<F10>', function()
        require('dap').step_over()
      end, { desc = 'Step Over' })

      map('n', '<F11>', function()
        require('dap').step_into()
      end, { desc = 'Step Into' })

      map('n', '<F12>', function()
        require('dap').step_out()
      end, { desc = 'Step Out' })

      map('n', '<leader>lp', function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end, { desc = 'Log point message' })

      map('n', '<leader>repl', function()
        require('dap').repl.open()
      end, { desc = 'Open REPL' })

      map('n', '<leader>du', function()
        require('dapui').toggle()
      end, { desc = 'Toggle DAP GUI' })

      map('n', '<leader>vl', function()
        require('dapui').eval()
      end, { desc = 'Evaluate expression' })
    end,
    dependencies = {
      { 'nvim-neotest/nvim-nio' },
      {
        'rcarriga/nvim-dap-ui',
        config = function()
          require('dapui').setup()
          require('dap.ext.vscode').load_launchjs('.nvim/launch.json', nil)
        end,
      },
      {
        'mfussenegger/nvim-dap-python',
        config = function()
          -- local mason_venv_path = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
          local mason_venv_path = '~/ryeproject/.venv/bin/python'
          require('dap-python').setup(mason_venv_path)
        end,
      },
      {
        'leoluz/nvim-dap-go',
        ft = 'go',
        config = function(_, opts)
          require('dap-go').setup(opts)
        end,
      },
    },
  },
}
