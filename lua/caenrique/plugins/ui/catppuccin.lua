return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    custom_highlights = function(colors)
      -- local _ = {
      --   base = '#1e1e2e',
      --   blue = '#89b4fa',
      --   crust = '#11111b',
      --   flamingo = '#f2cdcd',
      --   green = '#a6e3a1',
      --   lavender = '#b4befe',
      --   mantle = '#181825',
      --   maroon = '#eba0ac',
      --   mauve = '#cba6f7',
      --   overlay0 = '#6c7086',
      --   overlay1 = '#7f849c',
      --   overlay2 = '#9399b2',
      --   peach = '#fab387',
      --   pink = '#f5c2e7',
      --   red = '#f38ba8',
      --   rosewater = '#f5e0dc',
      --   sapphire = '#74c7ec',
      --   sky = '#89dceb',
      --   subtext0 = '#a6adc8',
      --   subtext1 = '#bac2de',
      --   surface0 = '#313244',
      --   surface1 = '#45475a',
      --   surface2 = '#585b70',
      --   teal = '#94e2d5',
      --   text = '#cdd6f4',
      --   yellow = '#f9e2af',
      -- }
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
}
