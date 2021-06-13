vim.cmd [[packadd packer.nvim]]

return require("packer").startup {
  function()
    use { "rmagatti/auto-session" }
    use { "kyazdani42/nvim-tree.lua", requires = {{ "kyazdani42/nvim-web-devicons" }}  }
  end
}
