return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    -- term_colors = true,
    -- compile = {
    --   enabled = true,
    -- },
    dim_inactive = {
      enabled = false,
      -- shade = 'dark',
      -- percentage = 0.15,
    },
    -- integrations = {
    --   neotree = true,
    --   neogit = true,
    --   telescope = true,
    --   cmp = true,
    --   gitsigns = true,
    --   native_lsp = {
    --     enabled = true,
    --     virtual_text = {
    --       errors = { 'italic' },
    --       hints = { 'italic' },
    --       warnings = { 'italic' },
    --       information = { 'italic' },
    --     },
    --     underlines = {
    --       errors = { 'undercurl' },
    --       hints = { 'undercurl' },
    --       warnings = { 'undercurl' },
    --       information = { 'undercurl' },
    --     },
    --   },
    -- },
    custom_highlights = function(colors)
      local util = require('catppuccin.utils.colors')
      local diff = {
        delete = {
          bg = util.blend('#f85149', colors.base, 0.1),
          bgText = util.blend('#f85149', colors.base, 0.4),
          -- bgText = util.blend(colors.red, colors.base, 0.2),
          -- fg = colors.red,
          text = '#e6edf3',
          -- text = util.blend(colors.red, colors.base, 0.1),
        },
        add = {
          -- bg = util.blend(colors.green, colors.base, 0.1),
          bg = util.blend('#2ea043', colors.base, 0.15),
          bgText = util.blend('#2ea043', colors.base, 0.4),
          -- bgText = util.blend(colors.green, colors.base, 0.2),
          -- fg = colors.green,
          text = '#e6edf3',
        },
      }
      return {
        DiffAdd = { bg = diff.add.bg }, -- fg = diff.add.fg },
        DiffDelete = { bg = diff.delete.bg }, -- fg = diff.delete.fg },
        DiffDeleteText = { bg = diff.delete.bgText, fg = diff.delete.text },
        DiffAddText = { bg = diff.add.bgText, fg = diff.add.text },
        DiffviewDiffDeleteDim = { fg = util.blend(colors.text, colors.base, 0.005) },
        DiffviewDiffDelete = { fg = util.blend(colors.text, colors.base, 0.005) },
        SnacksIndentScope = { fg = colors.blue },
      }
    end,
  },
}
