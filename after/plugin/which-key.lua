Cesar.require('which-key', {
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 500,
    icons = {
      mappings = vim.g.have_nerd_font,
    },

    preset = 'helix',

    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      -- { '<leader>d', group = '[D]ocument' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
  after = function()
    vim.keymap.set('n', '<C-;>', function() require('which-key').show({ global = false }) end,
      { desc = 'Buffer Local Keymaps (which-key)', })
    vim.keymap.set('n', '<C-Space>', function() require('which-key').show({ global = true }) end,
      { desc = 'Keymaps (which-key)', })
  end,
})
