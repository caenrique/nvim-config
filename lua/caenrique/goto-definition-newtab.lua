local M = {}

-- TODO: Handle the case where there are multiple definitions
-- TODO: If the definition is on the same buffer, don't open a new tab

local properties = {}

local function get_tracking_info()
  return {
    window_id = vim.api.nvim_get_current_win(),
    buffer_id = vim.api.nvim_get_current_buf(),
    cursor_pos = vim.api.nvim_win_get_cursor(0),
  }
end

local function goto_definition_this_tab()
  vim.lsp.buf.definition()
  table.insert(
    properties.jump_list,
    { buffer = vim.api.nvim_get_current_buf(), cursor_pos = vim.api.nvim_win_get_cursor(0) }
  )
end

local function goto_definition_newtab()
  print("goto_definition_newtab")
  local root = get_tracking_info()

  vim.api.nvim_command('tabnew')
  vim.api.nvim_set_current_buf(root.buffer_id)
  vim.api.nvim_win_set_cursor(0, root.cursor_pos)

  vim.lsp.buf.definition()

  properties = {
    tab_id = vim.api.nvim_get_current_tabpage(),
    root_win = root.window_id,
    root_buffer = root.buffer_id,
    jump_list = {},
  }
end

function M.goto_previous()
  if next(properties) == nil or properties.tab_id ~= vim.api.nvim_get_current_tabpage() then
    return
  end

  if next(properties.jump_list) == nil then
    vim.api.nvim_command('tabclose')
    vim.api.nvim_set_current_win(properties.root_win)
    properties = {}
  else
    local previous = table.remove(properties.jump_list)
    vim.api.nvim_set_current_buf(previous.buffer)
    vim.api.nvim_win_set_cursor(0, previous.cursor_pos)
  end
end

function M.goto_definition_tab()
  if next(properties) ~= nil and properties.tab_id == vim.api.nvim_get_current_tabpage() then
    goto_definition_this_tab()
  else
    goto_definition_newtab()
  end
end

function M.is_current_tab()
  return next(properties) and properties.tab_id == vim.api.nvim_get_current_tabpage()
end

return M
