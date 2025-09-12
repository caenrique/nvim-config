---@type vim.lsp.Config
return {
  on_init = function(client) client.server_capabilities.referencesProvider = false end,
}
