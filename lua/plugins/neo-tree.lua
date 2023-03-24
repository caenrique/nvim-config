return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
    { 's1n7ax/nvim-window-picker', version = 'v1.*' }
  },
  init = function()
    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
  end,
  opts = {
    enable_git_status = false,
    window = {
      width = 50,
      mappings = {
          ['v'] = 'open_vsplit',
          ['s'] = 'open_split',
          ['o'] = 'open',
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        always_show = {
          '.gitignore',
          '.scalafmt.conf',
          '.scalafix.conf',
        },
        never_show = {
          '.bloop',
          '.bsp',
          '.metals',
          '.git',
          '.github',
          '.idea',
          '.ruby-version',
          'node_modules',
          'history'
        }
      },
      use_libuv_file_watcher = true,
      group_empty_dirs = true,
      follow_current_file = true,
    }
  },
  keys = {
    { '<C-n>', function()
      require('neo-tree.command').execute({
        source = 'filesystem',
        position = 'left',
        toggle = true,
        reveal = true,
      })
    end
    }
  }
}
