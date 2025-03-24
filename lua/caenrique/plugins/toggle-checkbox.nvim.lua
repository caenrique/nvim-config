return {
  'opdavies/toggle-checkbox.nvim',
  keys = {
    {
      '<leader>x',
      function()
        require('toggle-checkbox').toggle()
      end,
      desc = 'Toggle [x] markdown checkboxes',
    },
  },
}
