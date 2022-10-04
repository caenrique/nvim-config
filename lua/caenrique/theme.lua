if not pcall(require, 'catppuccin') then
  return
end

local M = {}

function M.colors()
  return {
    diagnostics = {
      error = 'red',
      warning = 'yellow',
      info = 'blue',
      hint = 'sky',
    },
    diff        = {
      add = 'green',
      removed = 'red',
      changed = 'blue',
    },
    statusline  = {
      background = 'surface0',
    },
    text        = 'text',
    background  = 'base',
  }
end

function M.setup(flavor)
  vim.g.catppuccin_flavour = flavor
  require('catppuccin').setup({
    term_colors = true,
    compile = {
      enabled = true,
    },
    dim_inactive = {
      enabled = true,
      shade = "dark",
      percentage = 0.25,
    },
    integrations = {
      neotree = true,
      neogit = true,
      telescope = true,
      cmp = true,
      gitsigns = true,
    },
  })

  vim.cmd('colorscheme catppuccin')
end

vim.api.nvim_create_user_command('Theme', function(params)
  vim.cmd('Catppuccin ' .. params.args)
  local theme = require("catppuccin.palettes").get_palette(params.args)
  require('feline').use_theme(theme)
end, { nargs = 1, complete = function() return { 'latte', 'frappe', 'macchiato', 'mocha' } end })

return M
