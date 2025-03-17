-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Show which line your cursor is on only on the current window
local cursorline_group = vim.api.nvim_create_augroup('cursor-line-auto-command', {})
vim.api.nvim_create_autocmd('WinEnter', {
  group = cursorline_group,
  command = 'set cursorline',
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline_group,
  command = 'set nocursorline',
})

-- keymap for quickfix list to close it qith 'q'
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = true })
  end,
})
