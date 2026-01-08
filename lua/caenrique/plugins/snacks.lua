return {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    input = { enabled = true },
    notifier = { timeout = 3000 },
    -- scope = { enabled = false }, -- investigate this more. might be useful
  },
  keys = {
    { '<leader>N', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    { '<leader>gbl', function() Snacks.git.blame_line() end, desc = 'Blame line' },
  },
}
