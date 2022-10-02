local toggle_term = require('caenrique.toggle-term')

vim.g.auto_start_insert = 0

vim.keymap.set('n', '<C-/>', ':ToggleTerminal<CR>')
vim.keymap.set('t', '<C-/>', '<C-\\><C-n>:ToggleTerminal<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set({ 'n', 't' }, ';a', function() toggle_term.toggle('g:terminal_a') end)
vim.keymap.set({ 'n', 't' }, ';s', function() toggle_term.toggle('g:terminal_s') end)
vim.keymap.set({ 'n', 't' }, ';d', function() toggle_term.toggle('g:terminal_d') end)
vim.keymap.set({ 'n', 't' }, ';f', function() toggle_term.toggle('g:terminal_f') end)
vim.keymap.set({ 't', 'n' }, '<c-;>', toggle_term.toggle_last)
