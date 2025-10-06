return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'folke/snacks.nvim', -- optional
  },
  opts = {
    disable_context_highlighting = true,
    -- graph_style = 'ascii',
    process_pinner = true,
    commit_date_format = vim.fn.strftime('%c'),
    log_date_format = vim.fn.strftime('%c'),
    remember_settings = false,
    auto_refresh = false,
    kind = 'split_below',
    git_services = {
      ['github.com'] = 'https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1',
      ['ghe.siriusxm.com'] = 'https://ghe.siriusxm.com/${owner}/${repository}/compare/${branch_name}?expand=1',
    },
    integrations = {
      snacks = true,
      diffview = true,
    },
    console_timeout = 5000,
    commit_editor = {
      kind = 'vsplit',
      show_staged_diff = false,
      -- Accepted values:
      -- "split" to show the staged diff below the commit editor
      -- "vsplit" to show it to the right
      -- "split_above" Like :top split
      -- "vsplit_left" like :vsplit, but open to the left
      -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
      -- staged_diff_split_kind = 'split',
      spell_check = true,
    },
  },
  keys = {
    { '<leader>gg', function() require('neogit').open() end, desc = 'Git status buffer' },
  },
}
