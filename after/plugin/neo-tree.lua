Cesar.require('neo-tree', {
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = '', -- or "" to use 'winborder' on Neovim v0.11+
    source_selector = {
      winbar = true,
    },
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = '',
          deleted = ' ✖',
          modified = '',
          renamed = ' 󰁕',
          -- Status type
          untracked = '',
          ignored = ' ',
          unstaged = ' 󰄱',
          staged = ' ',
          conflict = ' ',
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
        ['<tab>'] = 'git_toggle_file_stage',
        ['<space>'] = '',
        ['<M-p>'] = {
          'toggle_preview',
          config = {
            use_float = false,
            use_snacks_image = false,
            use_image_nvim = false,
          },
        },
        ['H'] = '',
        ['f'] = '',
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
          ['H'] = '',
          ['f'] = '',
          ['<A-h>'] = 'toggle_hidden',
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
  after = function()
    vim.keymap.set('n', '<leader>e', function() vim.cmd('Neotree toggle') end, { desc = 'Toggle File Explorer' })
    vim.keymap.set(
      'n',
      '<leader>E',
      function() vim.cmd('Neotree toggle position=current') end,
      { desc = 'File Explorer in current window' }
    )
    vim.keymap.set(
      'n',
      '<leader>ge',
      function() vim.cmd('Neotree toggle source=git_status') end,
      { desc = 'Tree-like Git Status' }
    )
  end
})
