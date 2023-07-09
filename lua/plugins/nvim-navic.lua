return {
  'SmiteshP/nvim-navic',
  dependencies = 'neovim/nvim-lspconfig',
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
      end,
    })
  end,
}
