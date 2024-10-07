local c = require("plugins.heirline.components")
local conditions = require("heirline.conditions")
local colors = require("plugins.heirline.components.colors")
local util = require("catppuccin.utils.colors")

local space = c.utils.space
local align = c.utils.align

local default = {
  {
    hl = { bg = util.darken("#8aadf4", 0.8) },
    { hl = { fg = colors.bright_fg }, c.file_name },
    align,
    c.search_count,
    space,
    c.lsp.diagnostics,
  },
}

local terminal = {
  condition = function()
    return conditions.buffer_matches({ buftype = { "terminal" } })
  end,
  {
    c.filetype,
    space,
    c.terminal_name,
  },
}

local help = {
  condition = function()
    return conditions.buffer_matches({ buftype = { "help" } })
  end,
  {
    c.filetype,
    space,
    c.short_file_name,
  },
}

local inactive = {
  condition = conditions.is_not_active,
  { hl = { fg = colors.blue, bg = colors.bg, force = true }, c.file_name },
}

return {
  fallthrough = false,
  -- terminal,
  help,
  inactive,
  default,
}
