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
      { '<leader>E', function() vim.cmd('Neotree toggle position=current') end, desc = 'File Explorer' },
      { '<leader>ge', function() vim.cmd('Neotree toggle source=git_status') end, desc = 'Tree-like Git Status' },
    },
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = '', -- or "" to use 'winborder' on Neovim v0.11+
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = '',
            deleted = '✖',
            modified = '',
            renamed = '󰁕',
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '',
            conflict = '',
          },
        },
      },
      window = {
        width = 45,
        mappings = {
          -- Add git mappings
          ['gs'] = 'git_add_file',
          ['gS'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['gx'] = 'git_revert_file',
          ['ge'] = function() vim.cmd('Neotree toggle source=git_status') end,
          -- ['gd'] = function() vim.cmd('DiffViewOpen toggle source=git_status') end,
          ['<space>'] = '',
          ['<M-p>'] = {
            'toggle_preview',
            config = {
              use_float = false,
              use_snacks_image = false,
              use_image_nvim = false,
            },
          },
          ['l'] = 'focus_preview',
          ['<C-s>'] = 'open_split',
          ['<C-v>'] = 'open_vsplit',
          ['<C-t>'] = 'open_tabnew',
          ['<S-CR>'] = 'open_with_window_picker',
          ['<C-CR>'] = 'expand_all_subnodes',
          ['P'] = '',
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
            ['H'] = '',
            ['f'] = '',
          },
        },
      },
      git_status = {
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        window = {
          position = 'left',
          mappings = {
            ['gU'] = '',
            ['gS'] = '',
            ['ga'] = '',
            ['gc'] = '',
            ['gg'] = '',
            ['gp'] = '',
            ['gr'] = '',
          },
        },
      },
    },
  },
}
