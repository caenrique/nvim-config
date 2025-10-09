local group = vim.api.nvim_create_augroup('caenrique-events-group', { clear = true })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = group,
  callback = function() vim.highlight.on_yank() end,
})

local ignore_filetypes = { 'neo-tree' }
-- Show which line your cursor is on only on the current window
vim.api.nvim_create_autocmd({ 'WinEnter', 'InsertLeave' }, {
  group = group,
  callback = function()
    if not vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then vim.wo.cursorline = true end
  end,
})
vim.api.nvim_create_autocmd({ 'WinLeave', 'InsertEnter' }, {
  group = group,
  callback = function()
    if not vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then vim.wo.cursorline = false end
  end,
})

-- keymap for quickfix list to close it qith 'q'
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = group,
  callback = function() vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = true }) end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  group = group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- Auto-resize splits when terminal window is resized
vim.api.nvim_create_autocmd('VimResized', {
  group = group,
  callback = function() vim.cmd('tabdo wincmd =') end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, 'p') end
  end,
})

-- Wezterm integration -> Set tab title to neovim
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function() Wezterm.set_tab_title('neovim') end,
  group = group,
})
vim.api.nvim_create_autocmd('VimLeave', {
  callback = function() Wezterm.set_tab_title('') end,
  group = group,
})
