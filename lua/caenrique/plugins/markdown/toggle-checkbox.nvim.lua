return {
  'opdavies/toggle-checkbox.nvim',
  filetype = 'markdown',
  keys = {
    { '<leader>x', function() require('toggle-checkbox').toggle() end, desc = 'Toggle Markdown checkboxes' },
  },
}
