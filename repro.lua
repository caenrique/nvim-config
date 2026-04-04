vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
})

require('neo-tree').setup({
  source_selector = {
    winbar = true,
  },
  filesystem = {
    group_empty_dirs = true,
  },
})

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>e', function() vim.cmd('Neotree toggle') end, { desc = 'ToFile Explorer' })
