if not pcall(require, 'lspconfig') then
  return
end

local lspconfig = require('lspconfig')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    require('caenrique.lsp').setup_lsp_mappings(client, bufnr)
  end,
})

local sumneko_lua_commands = {}

if pcall(require, 'stylua-nvim') then
  sumneko_lua_commands.Format = {
    function()
      require('stylua-nvim').format_file()
    end
  }
end

lspconfig.sumneko_lua.setup({
  on_attach = function(client, bufnr)
    require('caenrique.lsp').setup_lsp_mappings(client, bufnr)
  end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  commands = sumneko_lua_commands,
})

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require('caenrique.lsp').setup_lsp_mappings(client, bufnr)
  end,
}
