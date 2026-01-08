return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {},
  init = function()
    -- Close Neotree before saving the session
    vim.api.nvim_create_autocmd('User', {
      pattern = { 'PersistenceSavePre' },
      group = vim.api.nvim_create_augroup('persistence-cesar', { clear = true }),
      command = 'Neotree close',
    })
  end,
}
