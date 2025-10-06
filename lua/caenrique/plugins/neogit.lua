return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'folke/snacks.nvim', -- optional
  },
  opts = {
    disable_context_highlighting = true,
    -- graph_style = 'ascii',
    process_spinner = true,
    commit_date_format = vim.fn.strftime('%c'),
    log_date_format = vim.fn.strftime('%c'),
    auto_refresh = true,
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
      kind = 'auto',
      show_staged_diff = false,
    },
  },
  keys = {
    { '<leader>gg', function() require('neogit').open() end, desc = 'Git status buffer' },
  },
}
