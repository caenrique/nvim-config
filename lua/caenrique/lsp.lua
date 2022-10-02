local M = {}

function M.setup_lsp_mappings(client, buffer)

  local capabilities = client.server_capabilities
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = buffer })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buffer })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = buffer })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = buffer })
  vim.keymap.set('n', 'gws', vim.lsp.buf.workspace_symbol, { buffer = buffer })
  vim.keymap.set('n', '<C-F>', vim.lsp.buf.format, { buffer = buffer })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = buffer })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = buffer })
  vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { buffer = buffer })
  vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { buffer = buffer })
  vim.keymap.set('n', '<C-[>', vim.diagnostic.goto_prev, { buffer = buffer })
  vim.keymap.set('n', '<C-]>', vim.diagnostic.goto_next, { buffer = buffer })

  local lsp_group = vim.api.nvim_create_augroup('lsp-autocmd', { clear = true })

  -- Create a command `:Format` local to the LSP buffer
  if capabilities.codeLensProvider then
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { buffer = buffer })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      callback = vim.lsp.codelens.refresh,
      group = lsp_group,
      buffer = buffer,
    })
  end

  if capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      callback = vim.lsp.buf.document_highlight,
      group = lsp_group,
      buffer = buffer,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      callback = vim.lsp.buf.clear_references,
      group = lsp_group,
      buffer = buffer,
    })
  end
end

return M
