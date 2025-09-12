---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    if vim.fn.bufname(bufnr):match(vim.fn.expand('~') .. '/Notes/.*$') then
      on_dir(vim.fs.root(0, vim.lsp.config.markdown_oxide.root_markers))
    end
  end,
  on_init = function(client)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.declarationProvider = false
    client.server_capabilities.definitionProvider = false
  end,
}
