Cesar.require('catppuccin', {
  opts = {
    custom_highlights = function(colors)
      local util = require('catppuccin.utils.colors')
      local diff_green = '#2ea043'

      return {
        DiffAdd = { bg = util.blend(diff_green, colors.base, 0.2) },
        DiffDelete = { bg = util.blend(colors.red, colors.base, 0.15) },
        DiffChange = { bg = util.blend(colors.blue, colors.base, 0.15) },
        DiffText = { bg = util.blend(colors.blue, colors.base, 0.5), fg = colors.text },

        DiffviewDiffDeleteDim = { fg = util.blend(colors.text, colors.base, 0.2) },

        SnacksIndentScope = { fg = colors.blue },
        SnacksIndentBlank = { fg = util.blend('#FFFFFF', colors.base, 0.1) },

        GitSignsChange = { fg = colors.blue },
        GitSignsChangeInline = { bg = util.blend(diff_green, colors.base, 0.5), fg = colors.text },
        GitSignsAddInline = { bg = util.blend(diff_green, colors.base, 0.5), fg = colors.text },
        GitSignsDeleteInline = { bg = util.blend(colors.red, colors.base, 0.5), fg = colors.text },

        BlinkCmpGhostText = { fg = util.darken(colors.text, 0.5), bg = colors.base },
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
  after = function()
    vim.cmd.colorscheme('catppuccin')
  end,
})
