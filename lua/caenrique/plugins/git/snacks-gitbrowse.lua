return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    gitbrowse = {
      url_patterns = {
        ['ghe.siriusxm.com'] = {
          branch = '/tree/{branch}',
          file = '/blob/{branch}/{file}#L{line_start}-L{line_end}',
          permalink = '/blob/{commit}/{file}#L{line_start}-L{line_end}',
          commit = '/commit/{commit}',
        },
      },
    },
  },
  keys = {
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Browse file on Remote' },
  },
}
