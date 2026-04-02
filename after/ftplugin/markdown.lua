vim.opt.conceallevel = 2
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 120
vim.opt_local.spell = true


Cesar.with('toggle-checkbox', {
  callback = function()
    vim.keymap.set('n', '<leader>x', require('toggle-checkbox').toggle, { desc = 'Toggle Markdown checkboxes' })
  end
})
