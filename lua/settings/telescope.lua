require('utils')
local cmd = vim.cmd
local g = vim.g
local actions = require('telescope.actions')

map("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files()<cr>")
map("n", "<leader>fg", "<cmd>lua require'telescope.builtin'.live_grep()<cr>")
map("n", "<leader>fb", "<cmd>lua require'telescope.builtin'.buffers()<cr>")
map("n", "<leader>fh", "<cmd>lua require'telescope.builtin'.help_tags()<cr>")
map("n", "<leader>c", "<cmd>lua require'telescope.builtin'.commands()<cr>")
map("n", "<leader>mc", "<cmd>lua require'telescope'.extensions.metals.commands()<cr>")
map("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>")
map("n", "<leader>km", "<cmd>lua require'telescope.builtin'.keymaps()<CR>")

require("telescope").setup {
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  },
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
  },
  extensions = {
    -- your extension config goes in here
  }
}
