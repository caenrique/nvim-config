return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<C-\>]],
    size = 20,
    on_create = function(term)
      vim.keymap.set({ "n", "t" }, "<C-t>", function()
        term:close()
        term:open(20, "tab")
      end, { noremap = true, silent = true, buffer = term.bufnr })

      vim.keymap.set({ "n", "t" }, "<C-h>", function()
        term:close()
        term:open(20, "horizontal")
      end, { noremap = true, silent = true, buffer = term.bufnr })
    end,
    winbar = {
      enabled = true,
    },
  },
  keys = {
    { "<Esc>", "<C-\\><C-n>", mode = "t" },
    "<C-\\>",
    { "<leader>1", "<cmd>1ToggleTerm<CR>" },
    { "<leader>4", "<cmd>4ToggleTerm<CR>" },
    { "<leader>5", "<cmd>5ToggleTerm<CR>" },
    { "<leader>6", "<cmd>6ToggleTerm<CR>" },
  },
}
