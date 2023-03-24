local function init()

  -- print("Reloadedddd!!!!!!!!!!!!!")
  local group = vim.api.nvim_create_augroup('theme', { clear = true })

  vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
      vim.wo.winhighlight = 'Normal:NormalNC,NormalNC:NormalNC'
    end,
    group = group,
  })

  vim.api.nvim_create_user_command('Theme',
    function(params)
      vim.cmd('Catppuccin ' .. params.args)
      local theme = require("catppuccin.palettes").get_palette(params.args)
      require('feline').use_theme(theme)
    end,
    {
      nargs = 1,
      complete = function()
        return { 'latte', 'frappe', 'macchiato', 'mocha' }
      end
    }
  )

  vim.cmd.colorscheme('catppuccin')
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  init = init,
  opts = function()
    vim.g.catppuccin_flavour = 'mocha'
    local colors = require("catppuccin.palettes").get_palette()
    local sticky_color = require('catppuccin.utils.colors').brighten(colors.blue, -0.7)

    return {
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
      custom_highlights = {
        -- Comment = { fg = colors.flamingo },
        -- TSComment = { fg = colors.surface2, style = { "italic" } },
        TreesitterContext = { bg = sticky_color, style = { "bold" } },
        TreesitterContextLineNumber = { fg = colors.text, bg = sticky_color, style = { "bold" } },
      }
    }
  end,
}
