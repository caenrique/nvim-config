local keymaps = require('caenrique.functions').keymaps
local keymap = require('caenrique.functions').keymap

local M = {}
-- require('legendary').bind_keymaps({ })
-- require('legendary').bind_keymaps({ })

function M.setup_lsp_mappings(client, buffer)
  local capabilities = client.server_capabilities
  keymaps({
    {
      '<c-o>',
      function()
        if require('caenrique.goto-definition-newtab').is_current_tab() then
          require('caenrique.goto-definition-newtab').goto_previous()
        else
          local ctrlO = vim.api.nvim_replace_termcodes("<C-o>", true, false, true)
          vim.api.nvim_feedkeys(ctrlO, 'n', false)
        end
      end,
      description = 'go to previous buffer in the definitions jump list',
    },
    {
      'gd',
      function()
        require('caenrique.goto-definition-newtab').goto_definition_tab()
      end,
      description = 'Go to definition in a new tab',
    },
    { 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', description = 'Go to definition' },
    { 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', description = 'Hover' },
    { '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', description = 'Signature help' },
    { 'gws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', description = 'Go to workspace symbol' },
    { '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', description = 'Rename symbol under cursor' },
    { '<C-f>', "<cmd>lua require('caenrique.functions').format_code()<CR>", description = 'Format code' },
    { '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', description = 'Code action' },
    { '<leader>k', '<cmd>lua vim.diagnostic.open_float()<CR>', description = 'Show diagnostics in a floating window' },
    {
      '<leader>d',
      '<cmd>lua vim.diagnostic.setloclist()<CR>',
      description = 'Add buffer diagnostics to the location list',
    }, -- buffer diagnostics only
    { '<C-[>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', description = 'Move to the previous diagnostic' },
    { '<C-]>', '<cmd>lua vim.diagnostic.goto_next()<CR>', description = 'Move to the next diagnostic' },
  }, { buffer = buffer })

  local lsp_group = vim.api.nvim_create_augroup('lsp-autocmd', { clear = true })

  if capabilities.documentFormattingProvider then
    keymap({
      '<C-F>',
      function()
        vim.lsp.buf.format()
      end,
      opts = { buffer = buffer },
    })
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
      group = lsp_group,
      buffer = buffer,
    })
  else
    keymap({ '<C-F>', '<cmd>Format<CR>', opts = { buffer = buffer } })
  end

  if capabilities.codeLensProvider then
    keymap({
      '<leader>cl',
      function()
        vim.lsp.codelens.run()
      end,
      description = 'Run the code lens in the current line',
      opts = { buffer = buffer },
    })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      group = lsp_group,
      buffer = buffer,
    })
  end

  if capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      group = lsp_group,
      buffer = buffer,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      group = lsp_group,
      buffer = buffer,
    })
  end
end

return M
