local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end

vim.cmd [[packadd packer.nvim]]

return require("packer").startup {
  function()
    use {"wbthomason/packer.nvim"}
    use {"rmagatti/auto-session"}
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {"caenrique/nvim-toggle-terminal"}
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"nvim-treesitter/playground"}
    use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}}
    use {"hrsh7th/nvim-compe", requires = {{"hrsh7th/vim-vsnip"}}}
    use {"mfussenegger/nvim-dap"}
    use {"scalameta/nvim-metals"}
    use {"kyazdani42/nvim-tree.lua", requires = {{"kyazdani42/nvim-web-devicons"}}}
    use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons", opt = true}}
    use {"folke/tokyonight.nvim"}
    use {"ray-x/lsp_signature.nvim"}
    use {"windwp/nvim-autopairs"}
    use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim"}
    use {"sindrets/diffview.nvim"}
    use {"tpope/vim-fugitive"}
    use {"tpope/vim-rhubarb"}
  end
}
