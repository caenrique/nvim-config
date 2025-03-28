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
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = { disable = { 'missing-fields', 'duplicate-set-field' } },
          },
        },
      },
      markdown_oxide = {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = function(client, _)
          vim.api.nvim_create_user_command('Daily', function(args)
            client:exec_cmd({ command = 'jump', arguments = { args.args } })
          end, { desc = 'Open daily note', nargs = '*' })
        end,
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
      'yaml-language-server',
      'jsonls',
      -- 'marksman',
      'markdown_oxide',
    })
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    require('mason-lspconfig').setup({
      ensure_installed = {}, -- explicitly set to an empty table (installs populated via mason-tool-installer)
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          server.capabilities = require('blink.cmp').get_lsp_capabilities(server.capabilities)
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })
  end,
}
