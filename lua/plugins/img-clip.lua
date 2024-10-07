return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  ft = "markdown",
  opts = {
    default = {
      dir_path = "images",
      relative_to_current_file = true,
      insert_mode_after_paste = false,
      show_dir_path_in_prompt = true,
    },
    dirs = {
      ["/Users/cesar.enrique/Projects/ghe.siriusxm.com/playback-documentation"] = {
        dir_path = function()
          return "images/" .. vim.fn.expand("%:t:r")
        end,
      },
    },
  },
  keys = {
    -- suggested keymap
    { "<leader>ip", "<cmd>PasteImage<cr>", ft = "markdown", desc = "Paste image from system clipboard" },
  },
}
