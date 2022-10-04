if not pcall(require, 'metals') then
  return
end

local function metals_keymaps(bufnr)
  vim.keymap.set('n', '<leader>ws', '<cmd>lua require"metals".hover_worksheet()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>sf', function() require('metals').run_scalafix() end, { buffer = bufnr })
  vim.keymap.set('n', '<leader>a', '<cmd>lua require"metals".open_all_diagnostics()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>tv', [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]], { buffer = bufnr })
  vim.keymap.set('n', '<leader>tr', [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]], { buffer = bufnr })
end

local function scalafix_autocmd()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.scala", "*.sbt", "*.java" },
    callback = function()
      require("metals").run_scalafix()
    end,
    group = nvim_metals_group,
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local metals_config = require('metals').bare_config()

metals_config.capabilities = capabilities
metals_config.init_options.statusBarProvider = 'on'
metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
}

metals_config.on_attach = function(client, bufnr)
  require('caenrique.lsp').setup_lsp_mappings(client, bufnr)
  metals_keymaps(bufnr)
  -- scalafix_autocmd()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
