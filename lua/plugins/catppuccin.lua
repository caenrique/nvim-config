local function init()
  -- print("Reloadedddd!!!!!!!!!!!!!")
  local group = vim.api.nvim_create_augroup("theme", { clear = true })

  vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
      vim.wo.winhighlight = "Normal:NormalNC,NormalNC:NormalNC"
    end,
    group = group,
  })

  vim.api.nvim_create_user_command("Theme", function(params)
    vim.cmd("Catppuccin " .. params.args)
    -- local theme = require('catppuccin.palettes').get_palette(params.args)
    -- require('feline').use_theme(theme)
  end, {
    nargs = 1,
    complete = function()
      return { "latte", "frappe", "macchiato", "mocha" }
    end,
  })

  vim.cmd.colorscheme("catppuccin")
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  init = init,
  opts = function()
    vim.g.catppuccin_flavour = "mocha"

    return {
      term_colors = true,
      compile = {
        enabled = true,
      },
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        neotree = true,
        neogit = true,
        telescope = true,
        cmp = true,
        gitsigns = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
      custom_highlights = function(colors)
        local util = require("catppuccin.utils.colors")
        local sticky_color = util.brighten(colors.blue, -0.7)

        local blend = function(color)
          return util.blend(color, colors.base, 0.3)
        end

        local diff = {
          delete = {
            bg = util.blend("#f85149", colors.base, 0.1),
            bgText = util.blend("#f85149", colors.base, 0.4),
            -- bgText = util.blend(colors.red, colors.base, 0.2),
            -- fg = colors.red,
            text = "#e6edf3",
            -- text = util.blend(colors.red, colors.base, 0.1),
          },
          add = {
            -- bg = util.blend(colors.green, colors.base, 0.1),
            bg = util.blend("#2ea043", colors.base, 0.15),
            bgText = util.blend("#2ea043", colors.base, 0.4),
            -- bgText = util.blend(colors.green, colors.base, 0.2),
            -- fg = colors.green,
            text = "#e6edf3",
          },
        }
        -- vim.print(colors)
        return {

          TSComment = { fg = colors.surface2, style = { "italic" } },
          TreesitterContext = { bg = sticky_color, style = { "bold" } },
          TreesitterContextLineNumber = { fg = colors.text, bg = sticky_color, style = { "bold" } },

          StatusColumnBorder = { fg = colors.blue, bg = colors.base },
          StatusColumnBuffer = { fg = "NONE", bg = "NONE" },
          StatusColumnBufferCursorLine = { fg = "NONE", bg = colors.lavender },

          -- NeoTree Git
          NeoTreeGitAdded = { bg = blend(colors.green) },
          NeoTreeGitConflict = { bg = blend(colors.red) },
          NeoTreeGitDeleted = { bg = blend(colors.red) },
          NeoTreeGitModified = { bg = blend(colors.yellow) },
          NeoTreeGitUnstaged = { bg = blend(colors.red) },
          NeoTreeGitUntracked = { bg = blend(colors.yellow), fg = colors.yellow },
          NeoTreeGitStaged = { bg = blend(colors.green) },
          WinSeparator = { fg = colors.blue },

          DiffAdd = { bg = diff.add.bg }, -- fg = diff.add.fg },
          DiffDelete = { bg = diff.delete.bg }, -- fg = diff.delete.fg },
          DiffDeleteText = { bg = diff.delete.bgText, fg = diff.delete.text },
          DiffAddText = { bg = diff.add.bgText, fg = diff.add.text },
          DiffviewDiffDeleteDim = { fg = util.blend(colors.text, colors.base, 0.005) },
          DiffviewDiffDelete = { fg = util.blend(colors.text, colors.base, 0.005) },
        }
      end,
    }
  end,
}
