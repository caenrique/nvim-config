return {
  'mstojanovic/bullets.vim',
  branch = 'fix_mark_for_chekbox_parent',
  init = function()
    -- vim.g.bullets_set_mappings = 0
    vim.g.bullets_checkbox_markers = ' X'
  end,
  ft = { 'markdown' },
}
