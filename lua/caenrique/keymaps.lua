vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>')
vim.keymap.set('n', 'th', ':tabprev<CR>')
vim.keymap.set('n', 'tl', ':tabnext<CR>')
vim.keymap.set('n', 'td', ':tabclose<CR>')
vim.keymap.set('n', 'gh', '<C-W>h')
vim.keymap.set('n', 'gl', '<C-W>l')
vim.keymap.set('n', 'gk', '<C-W>k')
vim.keymap.set('n', 'gj', '<C-W>j')
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>')
vim.keymap.set('n', '<C-6>', '<C-^>')
vim.keymap.set('n', '<C-q>', '<C-w>q')

vim.keymap.set({ 'n', 'v' }, 'j', "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count ? 'k' : 'gk'", { expr = true })

vim.keymap.set('v', '[', '"ss[<C-R>s]<esc>')
vim.keymap.set('v', '{', '"ss{<C-R>s}<esc>')
vim.keymap.set('v', '(', '"ss(<C-R>s)<esc>')
vim.keymap.set('v', '"', '"ss"<C-R>s"<esc>')
vim.keymap.set('v', "'", '"ss\\"<C-R>s\\"<esc>')

-- TODO: Find a proper mapping for next/previous occurence for a find command (find in line with f). It's slow because I use `;` for other mappings
