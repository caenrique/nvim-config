vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰛨',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    },
  },
})

-- Diagnostic keymaps
vim.keymap.set('n', 'gq', vim.diagnostic.setqflist,
  { desc = 'Diagnostic: Set the quickfix list with workspace diagnostics' })
vim.keymap.set('n', 'gl', vim.diagnostic.setloclist, { desc = 'Diagnostic: Set the local list with file diagnostics' })
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Diagnostic: Open diagnostic float' })
