local function tab_terminal(id)
  vim.cmd.tabnew()
  require('buffer-term').toggle(id)
end

return {
  'caenrique/buffer-term.nvim',
  dev = true,
  config = function()
    require('buffer-term').setup()
  end,
  keys = {
    { '<Esc>', '<C-\\><C-n>', mode = 't' },
    { '<C-;>', function() require('buffer-term').toggle_last() end, mode = { 'n', 't' } },
    { ';a', function() require('buffer-term').toggle('a') end, mode = { 'n', 't' } },
    { ';s', function() require('buffer-term').toggle('s') end, mode = { 'n', 't' } },
    { ';d', function() require('buffer-term').toggle('d') end, mode = { 'n', 't' } },
    { ';f', function() require('buffer-term').toggle('f') end, mode = { 'n', 't' } },
  },
}
