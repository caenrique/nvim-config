return {
  'zk-org/zk-nvim',
  config = function()

    require('zk').setup({
      picker = 'telescope',
      lsp = {
        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
        },
      },
    })

    vim.api.nvim_create_user_command('Postmortem', "ZkNew { title = vim.fn.input('Title: '), dir = '2-postmortem' }<cr>"
      , {})
    vim.api.nvim_create_user_command('Meeting', "ZkNew { title = vim.fn.input('Title: '), dir = '2-meetings' }<cr>", {})
    vim.api.nvim_create_user_command('Reference', "ZkNew { title = vim.fn.input('Title: '), dir = '3-references' }<cr>",
      {})

  end,
  keys = {
    { '<leader>zn', "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = '0-inbox' }<cr>" },
    { '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>" },
    { '<leader>zg', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>" },
    { '<leader>zk', '<Cmd>ZkTags<CR>' },
  },
  cmd = { 'Postmortem', 'Meeting', 'Reference' }
}
