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
      local theme = require('catppuccin.palettes').get_palette(params.args)
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
  'catppuccin/nvim',
  name = 'catppuccin',
  init = init,
  opts = function()
    vim.g.catppuccin_flavour = 'mocha'

    return {
      term_colors = true,
      compile = {
        enabled = true,
      },
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.25,
      },
      integrations = {
        neotree = true,
        neogit = true,
        telescope = true,
        cmp = true,
        gitsigns = true,
      },
      custom_highlights = function(colors)
        local util = require('catppuccin.utils.colors')
        local sticky_color = util.brighten(colors.blue, -0.7)
        local diffChangeColor = util.blend(colors.blue, colors.base, 0.3)

        local blend = function(color) return util.blend(color, colors.base, 0.3) end
        -- vim.print(colors)
        return {
          TSComment                    = { fg = colors.surface2, style = { 'italic' } },
          TreesitterContext            = { bg = sticky_color, style = { 'bold' } },
          TreesitterContextLineNumber  = { fg = colors.text, bg = sticky_color, style = { 'bold' } },
          StatusColumnBorder           = { fg = colors.blue, bg = colors.base },
          StatusColumnBuffer           = { fg = 'NONE', bg = 'NONE' },
          StatusColumnBufferCursorLine = { fg = 'NONE', bg = colors.lavender },
          DiffAdd                      = { fg = colors.green },
          DiffDelete                   = { fg = colors.red },
          DiffText                     = { fg = colors.text, bg = util.blend(colors.blue, colors.base, 0.6) },
          DiffChange                   = { bg = diffChangeColor },
          -- NeoTree Git
          NeoTreeGitAdded              = { bg = blend(colors.green) },
          NeoTreeGitConflict           = { bg = blend(colors.red) },
          NeoTreeGitDeleted            = { bg = blend(colors.red) },
          NeoTreeGitModified           = { bg = blend(colors.yellow) },
          NeoTreeGitUnstaged           = { bg = blend(colors.red) },
          NeoTreeGitUntracked          = { bg = blend(colors.yellow), fg = colors.yellow },
          NeoTreeGitStaged             = { bg = blend(colors.green) },
          WinSeparator                 = { fg = colors.overlay0 },
        }
      end
    }
  end,
}
