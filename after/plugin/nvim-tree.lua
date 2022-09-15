if not pcall(require, 'nvim-tree') then
  return
end

-- nvim_tree_ignore, nvim_tree_gitignore, nvim_tree_disable_window_picker, nvim_tree_window_picker_exclude

vim.cmd([[
  let g:nvim_tree_indent_markers = 1
  let g:nvim_tree_add_trailing = 1
  let g:nvim_tree_group_empty = 1
  let g:nvim_tree_special_files = ['README.md', 'Makefile', 'MAKEFILE']
  let g:nvim_tree_show_icons = { 'git': 1, 'folders': 1, 'files': 1, 'folder_arrows': 0 }

  nnoremap <silent> <C-n> :NvimTreeToggle<CR>
  set termguicolors
]])

require('nvim-tree').setup({
  filters = {
    custom = {'.git', 'node_modules'},
  },
  disable_netrw = true,
  git = {
    ignore = true
  },
  ignore_ft_on_setup = { 'startify', 'dashboard' },
  auto_close = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = 'open',
    args = {},
  },
  view = {
    auto_resize = true,
    width = 55,
  },
})
