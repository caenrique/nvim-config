require("neo-tree").setup({
  window = {
    width = 50,
    mappings = {
      ["s"] = "open_split",
      ["v"] = "open_vsplit",
    },
  },
  filesystem = {
    filtered_items = {
      ".gitignored",
    },
    use_libuv_file_watcher = true,
    group_empty_dirs = true,
  },
})

vim.keymap.set({'n', 'v'}, '<C-n>', ':Neotree filesystem toggle<CR>')
