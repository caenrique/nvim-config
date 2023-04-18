if not pcall(require, 'feline') or true then
  return
end

local colors = require('caenrique.colors')
local catppuccin = require('catppuccin.palettes').get_palette()
local components = require('caenrique.feline.components')

local function focus(component, focus_color)
  focus_color = focus_color or catppuccin.teal
  return vim.tbl_deep_extend('force', component, {
    left_sep = { hl = { bg = focus_color } },
    right_sep = { hl = { bg = focus_color } },
    hl = { bg = focus_color, fg = '#000000', style = 'bold' }
  })
end

local function invert_colors(component)
  local fg = component.hl.fg
  local bg = component.hl.bg

  return vim.tbl_deep_extend('force', component, {
    left_sep = { hl = { bg = fg } },
    right_sep = { hl = { bg = fg } },
    hl = { bg = fg, style = 'bold', fg = bg }
  })
end

vim.o.laststatus = 3

require('feline').setup({
  theme = catppuccin,
  components = {
    active = {
      {
        components.vim_mode,
        components.cwd,
        components.git_branch,
      },
      {
        components.metals_status,
        components.diagnostics.errors,
        components.diagnostics.warnings,
        components.diagnostics.info,
        components.diagnostics.hints,
        components.language_server,
      },
    },
    inactive = {
      {
        components.cwd,
        components.git_branch,
      },
      {},
    }
  },
  vi_mode_colors = colors.vi_mode_colors,
  force_inactive = {
    filetypes = {
      '^NvimTree$',
      '^packer$',
      '^startify$',
      '^fugitive$',
      '^fugitiveblame$',
      '^qf$',
      '^help$'
    },
    buftypes = {},
    bufnames = {}
  }
})

require('feline').winbar.setup({
  theme = catppuccin,
  components = {
    active = {
      {
        focus(components.file_info, catppuccin.red),
        -- components.navic
      },
      {
        invert_colors(components.git_diff.added),
        invert_colors(components.git_diff.removed),
        invert_colors(components.git_diff.changed),
      },
    },
    inactive = {

      { components.file_info },
      {
        components.git_diff.added,
        components.git_diff.removed,
        components.git_diff.changed,
      },
    },
  },
})

vim.api.nvim_create_user_command('FelineReload', 'luafile ~/.config/nvim/after/plugin/feline.lua', {})
