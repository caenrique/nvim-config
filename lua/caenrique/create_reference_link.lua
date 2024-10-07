local M = {}

---@return integer
local function get_link_id()
  local query = vim.treesitter.query.parse('markdown', '(link_reference_definition (link_label) @label)')

  local tree = vim.treesitter.get_parser():parse(nil)[1]
  local bufn = vim.api.nvim_get_current_buf()

  local nextReferenceNumber = 0
  for _, node, _ in query:iter_captures(tree:root(), bufn, 0, -1) do
    local text = vim.treesitter.get_node_text(node, bufn)
    local number = text:match('%d+') + 0

    if number > nextReferenceNumber then
      nextReferenceNumber = number
    end
  end

  return nextReferenceNumber + 1
end

function M.add_link_from_clipboard()
  local link = vim.fn.getreg('*')
  local id = get_link_id()

  if id == 1 then
    vim.api.nvim_buf_set_lines(0, -1, -1, false, { '' })
  end

  vim.api.nvim_buf_set_lines(0, -1, -1, false, { '[' .. id .. ']: ' .. link })
end

return M
