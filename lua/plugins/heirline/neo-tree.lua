return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
    { 's1n7ax/nvim-window-picker', version = 'v1.*' }
  },
  config = function()
    local fc = require('neo-tree.sources.filesystem.components')

    require('neo-tree').setup({
      enable_git_status = false,
      enable_diagnostics = false,
      window = {
        width = 40,
        mappings = {
            ['v'] = 'open_vsplit',
            ['s'] = 'open_split',
            ['o'] = 'open',
        },
      },
      filesystem = {
        components = {
          name = function(config, node, state)
            local result = fc.name(config, node, state)
            if node:get_depth() == 1 and node.type ~= 'message' and string.len(result.text) >= 40 then
              result.text = vim.fn.fnamemodify(node.path, ':t')
            elseif node.type ~= 'message' and string.len(result.text) >= 40 then
              result.text = vim.fn.pathshorten(node.name, 3)
            end
            return result
          end,
        },
        filtered_items = {
          visible = true,
          always_show = {
            '.gitignore',
            '.scalafmt.conf',
            '.scalafix.conf',
            '.github',
          },
          never_show = {
            '.bloop',
            '.bsp',
            '.metals',
            '.git',
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
    })
  end,
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
