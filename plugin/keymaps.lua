-- Debug keymaps to evaluate lua code of the whole file or visual selection
vim.keymap.set('n', 'g==', '<cmd>source %<CR>')
vim.keymap.set({ 'n', 'x' }, 'g==', ":'<,'>source<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Make global marks accesible in the home row
vim.keymap.set('n', "'a", "'A")
vim.keymap.set('n', 'ma', 'mA')

vim.keymap.set('n', "'s", "'S")
vim.keymap.set('n', 'ms', 'mS')

vim.keymap.set('n', "'d", "'D")
vim.keymap.set('n', 'md', 'mD')

vim.keymap.set('n', "'f", "'F")
vim.keymap.set('n', 'mf', 'mF')

vim.keymap.set({ 'n', 'x' }, '<leader>p', '"*p')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"*y')

vim.keymap.set('n', 'dm', require('caenrique.delete-mark').delete_marks)

vim.keymap.set('n', 'th', '<cmd>tabprev<cr>', { desc = 'Go to the [T]ab to the left' })
vim.keymap.set('n', 'tl', '<cmd>tabnext<cr>', { desc = 'Go to the [T]ab to the right' })
vim.keymap.set('n', 'td', '<cmd>tabclose<cr>', { desc = '[T]ab [D]delete' })
