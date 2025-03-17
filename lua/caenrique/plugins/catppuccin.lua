return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    custom_highlights = function(colors)
      local util = require('catppuccin.utils.colors')
      local green = '#2ea043'
      local red = '#f85149'
      local diff = {
        delete = {
          text = '#e6edf3',
          bg = util.blend(colors.red, colors.base, 0.15),
          bgText = util.blend(colors.red, colors.base, 0.5),
        },
        add = {
          text = '#e6edf3',
          bg = util.blend(green, colors.base, 0.15),
          bgText = util.blend('#2ea043', colors.base, 0.5),
        },
      }

      return {
        DiffAdd = { bg = diff.add.bg },
        DiffDelete = { bg = diff.delete.bg },
        DiffDeleteText = { bg = diff.delete.bgText, fg = diff.delete.text },
        DiffAddText = { bg = diff.add.bgText, fg = diff.add.text },
        DiffviewDiffDeleteDim = { fg = util.blend(colors.text, colors.base, 0.005) },
        DiffviewDiffDelete = { fg = util.blend(colors.text, colors.base, 0.005) },
        SnacksIndentScope = { fg = colors.blue },
        SnacksIndentBlank = { fg = util.blend('#FFFFFF', colors.base, 0.1) },
        GitSignsChange = { fg = colors.blue },
        GitSignsChangeInline = { bg = diff.add.bgText, fg = diff.add.text },
      }
    end,
    integrations = {
      gitsigns = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
    },
  },
}
