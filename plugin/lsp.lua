vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    -- local map = function(keys, func, desc, mode)
    --   mode = mode or 'n'
    --   vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    -- end

    -- - "gra" (Normal and Visual mode) is mapped to |vim.lsp.buf.code_action()|
    -- - "gri" is mapped to |vim.lsp.buf.implementation()|
    -- - "grn" is mapped to |vim.lsp.buf.rename()|
    -- - "grr" is mapped to |vim.lsp.buf.references()|
    -- - "grt" is mapped to |vim.lsp.buf.type_definition()|
    -- - "grx" is mapped to |vim.lsp.codelens.run()|
    -- - "gO" is mapped to |vim.lsp.buf.document_symbol()|
    -- - CTRL-S (Insert mode) is mapped to |vim.lsp.buf.signature_help()|
    -- - |v_an| and |v_in| fall back to LSP |vim.lsp.buf.selection_range()| if treesitter is not active.
    -- - |gx| handles `textDocument/documentLink`.
    --
    -- -- These LSP features are enabled by default:
    --
    -- BUFFER-LOCAL DEFAULTS
    --
    -- - 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger completion.
    -- - 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like go-to-definition, |:tjump|, and keymaps like |CTRL-]|, |CTRL-W_]|, |CTRL-W_}| to utilize the language server.
    -- - 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via |gq| if the language server supports it.
    -- - |K| is mapped to |vim.lsp.buf.hover()| unless 'keywordprg' is customized or a custom keymap for `K` exists.
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf, desc = 'LSP: go to definition' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- LSP code highlighting
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then

      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
        end,
      })
    end

    -- LSP inlay hints
    -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    -- map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end, '[T]oggle Inlay [H]ints')
    -- Snacks.toggle.inlay_hints():map('<leader>th')
    -- end

    -- LPS code lenses
    if client and client.server_capabilities.codeLensProvider then
      vim.lsp.codelens.enable(true)
    end

    if client and client.server_capabilities.inlayHintProvider then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
      end, { buf = event.buf, desc = 'Toggle Inlay Hints' })
    end


    vim.api.nvim_create_autocmd('LspProgress', { buffer = event.buf, callback = function(ev)
      local value = ev.data.params.value
      local client_name = vim.lsp.get_client_by_id(ev.data.client_id).config.name
      vim.api.nvim_echo({ { value.message or 'done' } }, false, {
        id = 'lsp.' .. ev.data.client_id,
        kind = 'progress',
        source = 'vim.lsp',
        title = string.format('[%s] %s', client_name, value.title),
        status = value.kind ~= 'end' and 'running' or 'success',
        percent = value.percentage,
      })
    end,
    })
  end,
})

local capabilities = {
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
  },
}
-- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config('*', {
  capabilities = capabilities,
})
