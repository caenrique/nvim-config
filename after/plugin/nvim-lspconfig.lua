if not pcall(require, "lspconfig") then
  return
end

local lspconfig = require("lspconfig")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
  end,
  capabilities = capabilities,
})

lspconfig.lua_ls.setup({
  commands = {
    Format = {
      require("stylua-nvim").format_file,
    },
  },
  on_attach = function(client, bufnr)
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
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
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
  end,
})

lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
  end,
})

lspconfig.smithy_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
  end,
  cmd = {
    "cs",
    "launch",
    "com.disneystreaming.smithy:smithy-language-server:0.0.10",
    "--",
    "0",
  },
  init_options = {
    statusBarProvider = "show-message",
    isHttpEnabled = true,
    compilerOptions = {
      snippetAutoIndent = false,
    },
  },
})

lspconfig.marksman.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- client.server_capabilities.codeLensProvider = false
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
  end,
})

require("lspconfig").bashls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
  end,
  filetypes = { "sh", "zsh" },
})

-- Setup the Unison LSP
require("lspconfig").unison.setup({
  on_attach = function(client, bufnr)
    require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
    -- -- Always show the signcolumn, otherwise it would shift the text each time
    -- -- diagnostics appear/become resolved
    -- vim.o.signcolumn = "yes"
    --
    -- -- Update the cursor hover location every 1/4 of a second
    -- vim.o.updatetime = 250
    --
    -- -- Disable appending of the error text at the offending line
    -- vim.diagnostic.config({ virtual_text = false })
  end,
})
