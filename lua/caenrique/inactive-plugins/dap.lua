return {
  {
    'mfussenegger/nvim-dap',
    config = function(self, opts)
      -- Debug settings if you're using nvim-dap
      local dap = require('dap')

      dap.configurations.scala = {
        {
          type = 'scala',
          request = 'launch',
          name = 'RunOrTest',
          metals = {
            runType = 'runOrTestFile',
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
          },
        },
        {
          type = 'scala',
          request = 'launch',
          name = 'Test Target',
          metals = {
            runType = 'testTarget',
          },
        },
      }

      vim.keymap.set(
        'n',
        '<leader>dt',
        function() require('dap').toggle_breakpoint() end,
        { desc = 'Dap Toggle Breakpoint' }
      )
      vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Dap Continue' })
      vim.keymap.set('n', '<leader>dr', function() require('dap').repl.toggle() end, { desc = 'Dap Repl Toggle' })
      vim.keymap.set('n', '<leader>dK', function() require('dap.ui.widgets').hover() end, { desc = 'Dap Hover' })
      vim.keymap.set('n', '<leader>dso', function() require('dap').step_over() end, { desc = 'Dap Step Over' })
      vim.keymap.set('n', '<leader>dsi', function() require('dap').step_into() end, { desc = 'Dap Step Into' })
      vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Dap Run Last' })
    end,
  },
  {
    'igorlfs/nvim-dap-view',
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        sections = { 'breakpoints', 'console', 'repl', 'watches', 'scopes', 'threads' },
        -- Must be one of the sections declared above (except for "console")
        default_section = 'repl',
        controls = {
          enabled = true,
        },
      },
    },
  },
}
