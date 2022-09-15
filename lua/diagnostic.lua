local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = "כֿ "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

require('caenrique.functions').keymap(
  { '<leader>q', function() vim.diagnostic.setqflist() end, description = 'Set quickfix list to workspace diagnostics from lsp and open the quickfix window' }
)
