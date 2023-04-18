local c = require('plugins.heirline.components')
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local space = c.utils.space
local align = c.utils.align

local default = {
  {
    provider = '',
    hl = { fg = 'bright_bg' }
  },
  {
    hl = { bg = 'bright_bg' },
    c.file_name,
    align,
    c.search_count,
    space,
    c.lsp.diagnostics,
  },
  {
    provider = '',
    hl = { fg = 'bright_bg' },
    condition = function() return not conditions.has_diagnostics() end,
  }
}

local terminal = {
  condition = function()
    return conditions.buffer_matches({ buftype = { 'terminal' } })
  end,
  utils.surround({ '', '' }, 'dark_red', {
    c.filetype,
    space,
    c.terminal_name,
  }),
}

local help = {
  condition = function()
    return conditions.buffer_matches({ buftype = { 'help' } })
  end,
  utils.surround({ '', '' }, 'bright_bg', {
    c.filetype,
    space,
    c.short_file_name,
  }),
}

local inactive = {
  condition = conditions.is_not_active,
  utils.surround({ '', '' }, 'bright_bg', { hl = { fg = 'blue', force = true }, c.file_name }),
}

return {
  fallthrough = false,
  terminal,
  help,
  inactive,
  default,
}
