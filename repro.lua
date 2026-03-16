vim.pack.add({
  'https://github.com/comfysage/artio.nvim',
})

require('vim._core.ui2').enable({ enable = true, msg = { target = 'msg' } })
require('artio').setup()

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>af', '<Plug>(artio-files)')
