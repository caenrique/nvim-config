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
    -- kind = 'floating',
    git_services = {
      ['github.com'] = 'https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1',
      ['ghe.siriusxm.com'] = 'https://ghe.siriusxm.com/${owner}/${repository}/compare/${branch_name}?expand=1',
    },
    integrations = {
      snacks = true,
      diffview = true,
    },
  },
  keys = {

    { '<leader>gg', function() require('neogit').open() end, desc = 'Git status buffer' },
  },
}
