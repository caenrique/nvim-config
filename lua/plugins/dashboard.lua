return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  enabled = false,
  config = function()
    require("dashboard").setup({
      config = {
        mru = {
          cwd_only = true,
        },
        project = {
          enable = false,
        },
        shuffle_letter = true,
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
