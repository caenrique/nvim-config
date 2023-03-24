return {
  'weilbith/nvim-code-action-menu',
  cmd = 'CodeActionMenu',
  keys = { { '<leader>a', ':CodeActionMenu<CR>', mode = 'n' } },
  init = function()
    vim.g.code_action_menu_show_details = false
  end
}
