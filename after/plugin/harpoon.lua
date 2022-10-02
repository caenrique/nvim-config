if not pcall(require, 'harpoon') then
  return
end

vim.keymap.set('n', '<leader>h', require('harpoon.ui').toggle_quick_menu)
vim.keymap.set('n', '<leader>m', require('harpoon.mark').add_file)
vim.keymap.set('n', "'a", function() require('harpoon.ui').nav_file(1) end)
vim.keymap.set('n', "'s", function() require('harpoon.ui').nav_file(2) end)
vim.keymap.set('n', "'d", function() require('harpoon.ui').nav_file(3) end)
vim.keymap.set('n', "'f", function() require('harpoon.ui').nav_file(4) end)
vim.keymap.set('n', "''", '<C-6>')
