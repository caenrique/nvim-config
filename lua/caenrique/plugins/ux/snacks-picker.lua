return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        grep = {
          finder = 'grep',
          regex = true,
          format = 'file',
          show_empty = true,
          live = true, -- live grep by default
          supports_live = true,
          formatters = {
            file = {
              filename_first = false,
              truncate = 40,
            },
          },
          layout = {
            hidden = {},
          },
        },
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 60,
        },
      },
      layout = {
        cycle = true,
        hidden = { 'preview' },
        --- Use the default layout or vertical if the window is too narrow
        preset = function() return vim.o.columns >= 160 and 'default' or 'vertical' end,
      },
      layouts = {
        vertical = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.9,
            min_height = 30,
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'preview', title = '{preview}', height = 0.5, border = 'bottom' },
            { win = 'input', height = 1, border = 'none' },
            { win = 'list', border = 'top' },
          },
        },
      },
    },
  },
  keys = {
    -- Top Pickers
    { '<leader>f', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader><space>', function() Snacks.picker.resume() end, desc = 'Smart Find Files' },
    -- Grep
    { '<leader>sb', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    {
      '<leader>sw',
      function() Snacks.picker.grep_word() end,
      desc = 'Grep Visual selection or word',
      mode = { 'n', 'x' },
    },
    -- Search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<leader>sr', function() Snacks.picker.recent() end, desc = 'Recent' },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sc', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sN', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
  },
}
