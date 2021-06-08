vim.cmd [[packadd packer.nvim]]

return require('packer').startup {
  function()
    use 'wbthomason/packer.nvim'
    use 'DevWurm/autosession.vim'
    use 'airblade/vim-gitgutter'
    use 'caenrique/nvim-toggle-terminal'
    use 'navarasu/onedark.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use 'neoclide/coc.nvim'
  end
}
