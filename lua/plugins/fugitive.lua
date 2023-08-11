return {
  'tpope/vim-fugitive',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'fugitive',
      callback = function()
        vim.keymap.set('n', 'q', '<cmd>q<CR>')
      end,
    })
  end,
  keys = { { '<leader>g', '<cmd>G<CR>' } },
  commands = { 'G' },
}
