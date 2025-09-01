return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- local servers = {
    --   lua_ls = {
    --     settings = {
    --       Lua = {
    --         completion = {
    --           callSnippet = 'Replace',
    --         },
    --         diagnostics = { disable = { 'missing-fields', 'duplicate-set-field' } },
    --       },
    --     },
    --   },
    -- }

    require('mason-tool-installer').setup({
      ensure_installed = {
        'lua_ls',
        'stylua', -- Used to format Lua code
        'yaml-language-server',
        'ts_ls',
        'jsonls',
        'pkl-lsp',
        'gopls',
      },
    })

    require('mason-lspconfig').setup({
      ensure_installed = {}, -- explicitly set to an empty table (installs populated via mason-tool-installer)
      automatic_enable = true,
      -- handlers = {
      --   function(server_name)
      --     local server = servers[server_name] or {}
      --     server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      --     server.capabilities = require('blink.cmp').get_lsp_capabilities(server.capabilities)
      --     require('lspconfig')[server_name].setup(server)
      --   end,
      -- },
    })

    -- pkl-lsp config
    vim.g.pkl_neovim = {
      start_command = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'pkl-lsp' },
      pkl_cli_path = vim.fn.stdpath('data') .. '/mason/packages/',
    }
  end,
}
