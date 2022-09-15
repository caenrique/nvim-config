if not pcall(require, 'metals') then
  return
end

local keymaps = require('caenrique.functions').keymaps

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

-- global
vim.opt_global.shortmess:remove('F'):append('c')

local metals_config = require('metals').bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
  serverVersion = "0.11.6+142-ad4708c1-SNAPSHOT",
}

metals_config.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = { prefix = '' },
})

metals_config.init_options.statusBarProvider = 'on'

-- Example if you are including snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

metals_config.capabilities = capabilities

metals_config.on_attach = function(client, bufnr)
  require('caenrique.lsp').setup_lsp_mappings(client, bufnr)
  require("nvim-navic").attach(client, bufnr)
  -- --
  -- print("metals attached!!")
  -- -- Specific metals mappings
  keymaps({
    { '<leader>ws', '<cmd>lua require"metals".hover_worksheet()<CR>' },
    { '<leader>sf', function() require('metals').run_scalafix() end },
    { '<leader>a', '<cmd>lua require"metals".open_all_diagnostics()<CR>' },
    { '<C-t>', [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]] },
    { '<leader>tr', [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]] },
  }, { buffer = bufnr })

  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   pattern = { "*.scala", "*.sbt", "*.java" },
  --   callback = function()
  --     require("metals").run_scalafix()
  --   end,
  --   group = nvim_metals_group,
  -- })
end


vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
