if not pcall(require, 'swap-buffers') then
  return
end

local keymaps = require('caenrique.functions').keymaps

keymaps({
  {
    '<leader>sh',
    "<cmd>lua require('swap-buffers').swap_buffers('h')<CR>",
    description = 'Swap current buffer with the one on the left',
  },
  {
    '<leader>sj',
    "<cmd>lua require('swap-buffers').swap_buffers('j')<CR>",
    description = 'Swap current buffer with the one on the bottom',
  },
  {
    '<leader>sk',
    "<cmd>lua require('swap-buffers').swap_buffers('k')<CR>",
    description = 'Swap current buffer with the one on top',
  },
  {
    '<leader>sl',
    "<cmd>lua require('swap-buffers').swap_buffers('l')<CR>",
    description = 'Swap current buffer with the one on the right',
  },
})
