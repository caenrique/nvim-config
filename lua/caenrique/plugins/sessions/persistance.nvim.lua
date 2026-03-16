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

    -- vim.api.nvim_create_autocmd('VimEnter', {
    --   group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
    --   callback = function()
    --     if vim.fn.getcwd() ~= vim.env.HOME and vim.fn.argc() == 0 then
    --       require('persistence').load()
    --     end
    --   end,
    --   nested = true,
    -- })

    vim.keymap.set('n', '<leader>Sd', function()
      local sessionfile = require('persistence').current()
      if vim.uv.fs_stat(sessionfile) then
        vim.fs.rm(sessionfile)
        vim.notify('Session file Deleted!')
      else
        vim.notify('Session file already deleted!')
      end
      require('persistence').stop()
    end)
    vim.keymap.set('n', '<leader>Sl', function() require('persistence').load() end)
  end,
}
