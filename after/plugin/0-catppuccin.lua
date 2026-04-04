Cesar.require('catppuccin', {
  opts = {
    lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
        ok = { "undercurl" },
      },
      inlay_hints = {
        background = true,
      },
    },
    highlight_overrides = {
      all = function(colors)
        local util = require('catppuccin.utils.colors')

        return {
          NeogitDiffDeleteInline = { bg = util.blend(colors.red, colors.base, 0.5), fg = colors.text },
          NeogitDiffAddInline = { bg = util.blend(colors.green, colors.base, 0.5), fg = colors.text },

          DiffviewDiffDeleteDim = { fg = util.blend(colors.text, colors.base, 0.2) },
          GitSignsChange = { fg = colors.blue },
          GitSignsChangeInline = { bg = util.blend(colors.green, colors.base, 0.5), fg = colors.text },
          GitSignsAddInline = { bg = util.blend(colors.green, colors.base, 0.5), fg = colors.text },
          GitSignsDeleteInline = { bg = util.blend(colors.red, colors.base, 0.5), fg = colors.text },
        }
      end,
    },
    integrations = {
      neotree = true,
      diffview = true,
      window_picker = true,
      snacks = {
        enabled = true,
        indent_scope_color = "blue"
      },
      which_key = true,
    },
  },
  after = function()
    vim.cmd.colorscheme('catppuccin')
  end,
})
