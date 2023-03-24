if not pcall(require, 'catppuccin') or not pcall(require, "window-picker") then
  return
end

local colors = require('catppuccin.palettes').get_palette(vim.g.catppuccin_flavour)

require('window-picker').setup({
    use_winbar = 'smart', -- "always" | "never" | "smart"
    fg_color = colors.base,
    other_win_hl_color = colors.green,
})
