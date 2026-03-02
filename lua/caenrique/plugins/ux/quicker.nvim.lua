return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    keys = {
      {
        '>',
        function() require('quicker').expand({ before = 2, after = 2, add_to_existing = true }) end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function() require('quicker').collapse() end,
        desc = 'Collapse quickfix context',
      },
    },
    highlight = {
      load_buffers = true,
    },
    opts = {
      winfixheight = false,
    },
    follow = {
      enabled = true,
    },
  },
  keys = {
    {
      '<leader>q',
      function() require('quicker').toggle({ focus = true, min_height = 5 }) end,
      desc = 'Toggle quickfix list',
    },
    {
      '<leader>l',
      function() require('quicker').toggle({ loclist = true, focus = true }) end,
      desc = 'Toggle location list',
    },
  },
}
