return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  enabled = true,
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 500,
    icons = {
      mappings = vim.g.have_nerd_font,
    },

    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      -- { '<leader>d', group = '[D]ocument' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
  keys = {
    {
      '<C-;>',
      function() require('which-key').show({ global = false }) end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
    {
      '<C-Space>',
      function() require('which-key').show({ global = true }) end,
      desc = 'Keymaps (which-key)',
    },
  },
}
