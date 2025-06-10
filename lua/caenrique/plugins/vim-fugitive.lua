return {
  'tpope/vim-fugitive', -- Git integration. Specifically I'm interested in the :G command
  init = function()
    vim.api.nvim_create_user_command('Gcommit', function(input) vim.cmd.G("commit -m '" .. input.args .. "'") end, {})
  end,
}
