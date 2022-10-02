if not pcall(require, 'feline') then
  return
end

local colors = require('caenrique.theme')
local components = require('caenrique.feline.components')

vim.o.laststatus = 3

require('feline').setup({
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
  components = {
    active = {
      {
        components.file_info,
        -- components.navic
      },
      {
        components.git_diff.added,
        components.git_diff.removed,
        components.git_diff.changed,
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

vim.api.nvim_create_user_command('FelineReload', 'source ~/.config/nvim/after/plugin/feline.lua', {})
