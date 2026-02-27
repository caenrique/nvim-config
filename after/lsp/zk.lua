---@type vim.lsp.Config
return {
  on_init = function(client)
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.definitionProvider = false
  end,
}
