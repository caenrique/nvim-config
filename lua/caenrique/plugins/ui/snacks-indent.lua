return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    indent = {
      enabled = false,
      indent = {
        enabled = true,
        hl = 'SnacksIndentBlank', ---@type string|string[] hl group for scopes
      },
      scope = {
        only_current = true, -- only show scope in the current window
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for scopes
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false
          and vim.b[buf].snacks_indent ~= false
          and vim.bo[buf].buftype == ''
          and vim.bo[buf].filetype ~= 'markdown' -- Disable in markdown buffers
          and vim.bo[buf].filetype ~= 'tvp' -- Disable in tvp buffers
      end,
    },
  },
}
