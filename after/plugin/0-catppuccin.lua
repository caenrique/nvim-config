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
        vim.print(vim.inspect(colors))

        return {
          NeogitDiffDeleteInline = { bg = util.blend(colors.red, colors.base, 0.4), fg = colors.red },
          NeogitDiffAddInline = { bg = util.blend(colors.green, colors.base, 0.4), fg = colors.green },

          DiffviewDiffDeleteDim = { fg = util.blend(colors.text, colors.base, 0.2) },
          GitSignsChange = { fg = colors.blue },
          GitSignsChangeInline = { bg = util.blend(colors.green, colors.base, 0.4), fg = colors.green },
          GitSignsAddInline = { bg = util.blend(colors.green, colors.base, 0.4), fg = colors.green },
          GitSignsDeleteInline = { bg = util.blend(colors.red, colors.base, 0.4), fg = colors.red },
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
