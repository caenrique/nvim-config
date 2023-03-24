local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = 'כֿ '
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float)
vim.keymap.set('n', '<C-[>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<C-]>', vim.diagnostic.goto_next)
