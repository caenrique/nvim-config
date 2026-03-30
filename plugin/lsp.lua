vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('<leader>cl', vim.lsp.codelens.run, '[C]ode [L]ens Run', { 'n' })
    -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[N]ame', { 'n', 'x' })
    map('gd', Snacks.picker.lsp_definitions, '[G]oto [D]efinition')
    map('gD', function()
      vim.cmd('vsplit')
      Snacks.picker.lsp_definitions()
    end, '[G]oto [D]efinition in a vertical split')
    -- map('<leader>r', Snacks.picker.lsp_references, '[R]eferences', { 'n', 'x' })
    map('gi', Snacks.picker.lsp_implementations, 'Goto Implementation')
    map('gy', Snacks.picker.lsp_type_definitions, 'Goto T[y]pe Definition')
    map('<leader>ss', Snacks.picker.lsp_symbols, 'LSP Symbols')
    map(
      '<leader>sws',
      function()
        Snacks.picker.lsp_workspace_symbols({
          live = true,
          matcher = {
            fuzzy = false,
            filename_bonus = false,
            file_pos = false,
          },
        })
      end,
      'LSP Workspace Symbols'
    )

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- LSP code highlighting
    if false and client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = function()
          if vim.b.not_clear_references then
            vim.b.not_clear_references = false
            return
          end

          vim.lsp.buf.clear_references()
        end,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
        end,
      })
    end

    -- LSP folds
    -- if client and client.server_capabilities.foldingRangeProvider then vim.opt_local.foldexpr = 'v:lua.vim.lsp.foldexpr()' end

    -- LSP inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      -- map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end, '[T]oggle Inlay [H]ints')
      Snacks.toggle.inlay_hints():map('<leader>th')
    end

    -- LPS code lenses
    if client and client.server_capabilities.codeLensProvider then
      vim.lsp.codelens.enable(true)
    end
  end,
})

local capabilities = {
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
  },
}
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config('*', {
  capabilities = capabilities,
})
