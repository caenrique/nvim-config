return {
  enabled = true,
  ---@class snacks.indent.Scope.Config: snacks.scope.Config
  indent = {
    hl = 'SnacksIndentBlank', ---@type string|string[] hl group for scopes
  },
  scope = {
    only_current = true, -- only show scope in the current window
    hl = 'SnacksIndentChunk', ---@type string|string[] hl group for scopes
  },
  -- filter for buffers to enable indent guides
  filter = function(buf)
    return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
  end,
}
