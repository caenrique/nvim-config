-- Change diagnostic symbols in the sign column (gutter)
if vim.g.have_nerd_font then
  -- local signs = { '', '', '', '󱠂' }
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = 'E',
        [vim.diagnostic.severity.WARN] = 'W',
        [vim.diagnostic.severity.INFO] = 'I',
        [vim.diagnostic.severity.HINT] = 'H',
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
        [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
        [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
      },
    },
    severity_sort = true,
    virtual_text = true,
    underline = true,
  })
end

-- Diagnostic keymaps
vim.keymap.set('n', 'gq', vim.diagnostic.setqflist, { desc = '[q]uickfix list workspace diagnostics' })
vim.keymap.set('n', 'gl', vim.diagnostic.setloclist, { desc = 'Open diagnostic [L]ocal [Q]uickfix list' })
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float)
