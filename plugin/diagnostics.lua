-- Change diagnostic symbols in the sign column (gutter)
if vim.g.have_nerd_font then
  local signs = { ERROR = '', WARN = '', INFO = '', HINT = '󱠂' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.diagnostic.config({ signs = { text = diagnostic_signs }, virtual_text = true, underline = true })
end

-- Diagnostic keymaps
vim.keymap.set('n', 'gq', vim.diagnostic.setqflist, { desc = '[q]uickfix list workspace diagnostics' })
vim.keymap.set('n', 'gl', vim.diagnostic.setloclist, { desc = 'Open diagnostic [L]ocal [Q]uickfix list' })
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float)
