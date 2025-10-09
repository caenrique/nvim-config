return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- 'nvim-tree/nvim-web-devicons', -- optional, but recommended
      -- 'nvim-tree/nvim-web-devicons', -- optional, but recommended
      's1n7ax/nvim-window-picker',
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { '<leader>e', function() vim.cmd('Neotree toggle') end, desc = 'File Explorer' },
      { '<leader>ge', function() vim.cmd('Neotree toggle source=git_status') end, desc = 'Tree-like Git Status' },
    },
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = '', -- or "" to use 'winborder' on Neovim v0.11+
      window = {
        width = 45,
        mappings = {
          ['<space>'] = nil,
          ['<M-p>'] = {
            'toggle_preview',
            config = {
              use_float = true,
              use_snacks_image = true,
              use_image_nvim = true,
            },
          },
          ['l'] = 'focus_preview',
          ['<C-s>'] = 'open_split',
          ['<C-v>'] = 'open_vsplit',
          ['<C-t>'] = 'open_tabnew',
          ['<S-CR>'] = 'open_with_window_picker',
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        window = {
          mappings = {
            ['<M-h>'] = 'toggle_hidden',
            ['H'] = nil,
            ['f'] = nil,
          },
        },
      },
      git_status = {
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        window = {
          rosition = 'left',
        },
      },
    },
  },
}
