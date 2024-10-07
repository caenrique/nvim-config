return {
  "tpope/vim-fugitive",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function(args)
        vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = args.buf })
      end,
    })
  end,
  keys = { { "<leader>g", "<cmd>G<CR>" } },
  commands = { "G" },
}
