return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    { 'williamboman/mason.nvim', opts = {} },
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
        'lua-language-server',
        'yaml-language-server',
        'typescript-language-server',
        'json-lsp',
        'markdown-oxide',
        'pkl-lsp',
        'stylua', -- Used to format Lua code
        'zk', -- note taking cli tool
        'rust-analyzer',
      },
    })

    vim.lsp.enable({ 'lua_ls', 'yamlls', 'jsonls', 'markdown_oxide', 'ts_ls' })

    -- pkl-lsp config
    vim.g.pkl_neovim = {
      start_command = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'pkl-lsp' },
      pkl_cli_path = vim.fn.stdpath('data') .. '/mason/packages/',
    }
  end,
}
