local signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = "כֿ "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)
