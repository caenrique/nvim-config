local colors = require("catppuccin.palettes").get_palette()
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

local M = {}

M.vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.blue,
    VISUAL = colors.flamingo,
    OP = colors.green,
    BLOCK = colors.flamingo,
    REPLACE = colors.red,
    ['V-REPLACE'] = colors.red,
    ENTER = colors.sky,
    MORE = colors.sky,
    SELECT = colors.peach,
    COMMAND = colors.red,
    SHELL = colors.green,
    TERM = colors.blue,
    NONE = colors.yellow
}

M.bg_statusline = colors.surface0

M.diff = {
  add = colors.green,
  removed = colors.red,
  changed = colors.blue
}

function M.setup()
  require('catppuccin').setup({
    term_colors = true,
    compile = {
      enabled = true,
    },
    integrations = {
      neotree = {
        enabled = true,
      },
      neogit = true,
    },
  })

  vim.cmd('colorscheme catppuccin')
end

return M
