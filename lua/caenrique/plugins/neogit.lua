return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
  },
  opts = {
    disable_context_highlighting = true,
    graph_style = 'ascii',
    process_pinner = true,
    commit_date_format = vim.fn.strftime('%c'),
    log_date_format = vim.fn.strftime('%c'),
    git_services = {
      ['github.com'] = 'https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1',
      ['ghe.siriusxm.com'] = 'https://ghe.siriusxm.com/${owner}/${repository}/compare/${branch_name}?expand=1',
    },
  },
  keys = {

    { '<leader>gg', function() require('neogit').open() end, desc = 'Lazygit' },
  },
}
