return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
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
        'terraform-ls',
        'jdtls',
        'lemminx',
      },
    })

    vim.lsp.enable({ 'lua_ls', 'yamlls', 'jsonls', 'markdown_oxide', 'ts_ls', 'terraformls', 'lemminx' })

    -- pkl-lsp config
    vim.g.pkl_neovim = {
      start_command = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'pkl-lsp' },
      pkl_cli_path = vim.fn.stdpath('data') .. '/mason/packages/',
    }
  end,
}
