Wezterm = {}

--- Wezterm api methods
local Api = {}

Api.list_clients = function()
  local response = vim.system({ 'wezterm', 'cli', 'list-clients', '--format', 'json' }, { text = true }):wait()
  return vim.json.decode(response.stdout)
end

Api.list = function()
  local response = vim.system({ 'wezterm', 'cli', 'list', '--format', 'json' }, { text = true }):wait()
  return vim.json.decode(response.stdout)
end

--- Sets the title of the current tab in wezterm
---@param title string
Api.set_tab_title = function(title)
  vim.system(
    { 'wezterm', 'cli', 'set-tab-title', title },
    {},
    ---@param out vim.SystemCompleted
    function(out)
      if out.code == 0 then vim.schedule(function() vim.notify('Tab title set to ' .. title) end) end
    end
  )
end

Wezterm.set_tab_title = Api.set_tab_title

Wezterm.list_panes = function()
  local client = Api.list_clients()[1]
  local panes = Api.list()

  local p = {}
  for _, pane in ipairs(panes) do
    if pane.workspace == client.workspace then table.insert(p, pane) end
  end

  return p
end
