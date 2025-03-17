return {
  'mrjones2014/smart-splits.nvim',
  opts = {
    log_level = 'debug',
    cursor_follows_swapped_bufs = true,
  },
  lazy = false,
  keys = {
    -- This plugin sets the IS_NVIM user variable in wezterm with string values 'true' or 'false'
    {
      '<A-h>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize window to the left',
    },
    {
      '<A-j>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize window down',
    },
    {
      '<A-k>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize window up',
    },
    {
      '<A-l>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize window to the right',
    },
    {
      '<C-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Move cursor to the left window',
    },
    {
      '<C-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Move cursor to the window below',
    },
    {
      '<C-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Move cursor to the window above',
    },
    {
      '<C-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Move cursor to the right window',
    },
    {
      '<C-\\>',
      function()
        require('smart-splits').move_cursor_previous()
      end,
      desc = 'Move cursor to the previous window',
    },
    {
      '<leader><leader>h',
      function()
        require('smart-splits').swap_buf_left()
      end,
      desc = 'Swap buffer to the left',
    },
    {
      '<leader><leader>j',
      function()
        require('smart-splits').swap_buf_down()
      end,
      desc = 'Swap buffer down',
    },
    {
      '<leader><leader>k',
      function()
        require('smart-splits').swap_buf_up()
      end,
      desc = 'Swap buffer up',
    },
    {
      '<leader><leader>l',
      function()
        require('smart-splits').swap_buf_right()
      end,
      desc = 'Swap buffer to the right',
    },
  },
}
