-- Debug keymaps to evaluate lua code of the whole file or visual selection
vim.keymap.set('n', 'g==', '<cmd>source %<CR>')
vim.keymap.set({ 'n', 'x' }, 'g==', ":'<,'>source<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
