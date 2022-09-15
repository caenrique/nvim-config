if not pcall(require, 'tokyonight') then
  return
end

vim.g.tokyonight_style = 'storm'
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { 'neo-tree', 'nvim_tree', 'qf', 'vista_kind', 'terminal', 'packer' }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = 'orange', error = '#ff0000' }

vim.g.tokyonight_dark_float = true
vim.g.caenrique_theme_dark = true

_G.toggle_theme = function()
  package.loaded['tokyonight.config'] = nil
  if vim.g.caenrique_theme_dark then
    vim.o.background = 'light'
    vim.g.tokyonight_style = 'day'
    vim.g.caenrique_theme_dark = false
  else
    vim.o.background = 'dark'
    vim.g.tokyonight_style = 'storm'
    vim.g.caenrique_theme_dark = true
  end
  require('tokyonight').colorscheme()
  vim.cmd('colorscheme tokyonight')
end

require('caenrique.functions').keymap({
  '<leader>`',
  '<CMD>lua toggle_theme()<CR>',
  description = 'Toggle dark and light theme variants',
})
