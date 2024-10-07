local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = "כֿ ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "[q]uickfix list workspace diagnostics" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "location list file diagnostics" })
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "diagnostic open float" })
