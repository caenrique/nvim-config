vim.keymap.set('n', '<C-o>', '<CMD>colder<CR>', { desc = 'Previous quickfix list', buffer = true })
vim.keymap.set('n', '<C-i>', '<CMD>cnewer<CR>', { desc = 'Previous quickfix list', buffer = true })

vim.keymap.set('n', 'dd', function()
  local qflist = vim.fn.getqflist()
  if #qflist == 0 then
    return
  end

  local line = vim.fn.line('.')
  table.remove(qflist, line)
  vim.fn.setqflist({}, ' ', { items = qflist })

  local new_count = #qflist

  if new_count > 0 then
    local new_line = math.min(line, new_count)
    vim.api.nvim_win_set_cursor(0, { new_line, 0 })
  end
end, {
  buffer = true,
  silent = true,
  desc = 'Delete entry in the quickfix list',
})

-- keymap for quickfix list to close it qith 'q'
vim.keymap.set('n', 'q', '<CMD>cclose<CR>', { buffer = true })

vim.wo.cursorline = true
