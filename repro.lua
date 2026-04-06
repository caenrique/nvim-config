vim.pack.add({
  'gh:esmuellert/codediff.nvim',
})

require('codediff').setup({
  keymaps = {
    view = {
      toggle_explorer = '<leader>e',
    },
    -- explorer = {
    -- toggle_explorer = '<leader>e',
    -- },
  },
})

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff<CR>', { desc = 'Open Diff view' })
