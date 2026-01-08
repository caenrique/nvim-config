return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'folke/snacks.nvim', -- optional
  },
  opts = {
    disable_context_highlighting = true,
    process_spinner = false,
    commit_date_format = vim.fn.strftime('%c'),
    log_date_format = vim.fn.strftime('%c'),
    auto_refresh = true,
    -- kind = 'split_below',
    kind = 'tab',
    git_services = {
      ['github.com'] = {
        pull_request = 'https://${host}/${owner}/${repository}/compare/${branch_name}?expand=1',
        commit = 'https://${host}/${owner}/${repository}/commit/${oid}',
        tree = 'https://${host}/${owner}/${repository}/tree/${branch_name}',
      },
      ['ghe.siriusxm.com'] = {
        pull_request = 'https://${host}/${owner}/${repository}/compare/${branch_name}?expand=1',
        commit = 'https://${host}/${owner}/${repository}/commit/${oid}',
        tree = 'https://${host}/${owner}/${repository}/tree/${branch_name}',
      },
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
    commit_order = '',
  },
  keys = {
    { '<leader>gs', function() require('neogit').open() end, desc = 'Git status buffer' },
    { '<leader>gS', function() require('neogit').open({ kind = 'tab' }) end, desc = 'Git status buffer' },
  },
}
