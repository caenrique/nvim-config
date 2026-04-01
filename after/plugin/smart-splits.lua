-- This plugin sets the IS_NVIM user variable in wezterm with string values 'true' or 'false'
Cesar.require('smart-splits', {
  opts = {
    cursor_follows_swapped_bufs = true,
  },
  after = function()
    vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize window to the left' })
    vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize window down' })
    vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize window up' })
    vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize window to the right' })
    vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move cursor to the left window' })
    vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move cursor to the window below' })
    vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move cursor to the window above' })
    vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move cursor to the right window' })
    vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous,
      { desc = 'Move cursor to the previous window' })
    vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left, { desc = 'Swap buffer to the left' })
    vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down, { desc = 'Swap buffer down' })
    vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up, { desc = 'Swap buffer up' })
    vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right,
      { desc = 'Swap buffer to the right' })
  end
})
