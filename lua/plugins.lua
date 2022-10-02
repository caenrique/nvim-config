require('packer').startup({
  {
    'machakann/vim-sandwich',
    'ckipp01/stylua-nvim',
    'L3MON4D3/LuaSnip',
    'caenrique/nvim-toggle-terminal',
    'caenrique/swap-buffers.nvim',
    -- 'folke/tokyonight.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'neovim/nvim-lspconfig',
    { 'jedrzejboczar/possession.nvim', requires = { 'nvim-lua/plenary.nvim' }, },
    'sindrets/diffview.nvim',
    'terrortylor/nvim-comment',
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'wbthomason/packer.nvim',
    'windwp/nvim-autopairs',
    'stevearc/dressing.nvim',
    'simrat39/symbols-outline.nvim',
    'feline-nvim/feline.nvim',
    'mrjones2014/legendary.nvim',
    { 'kevinhwang91/nvim-bqf' },
    { 'scalameta/nvim-metals', requires = 'nvim-lua/plenary.nvim' },
    { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    { 'SmiteshP/nvim-navic', requires = 'neovim/nvim-lspconfig' },
    { 'alvarosevilla95/luatab.nvim', requires = 'kyazdani42/nvim-web-devicons' },
    { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' },
    { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' },
    {
      'NTBBloodbath/rest.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      commit = '2826f6960fbd9adb1da9ff0d008aa2819d2d06b3',
    },
    {
      'hrsh7th/nvim-cmp',
      requires = {
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'onsails/lspkind-nvim',
        'hrsh7th/cmp-nvim-lsp-signature-help',
      },
    },
    {
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        {
          's1n7ax/nvim-window-picker',
          tag = 'v1.*',
          config = function()
            require('window-picker').setup()
          end,
        },
      },
    },
    { "catppuccin/nvim", as = "catppuccin" },
    {
      "nvim-neorg/neorg",
      requires = "nvim-lua/plenary.nvim"
    },
    'gaoDean/autolist.nvim',
    { 'alvarosevilla95/luatab.nvim', requires = 'kyazdani42/nvim-web-devicons' },
    { 'ThePrimeagen/harpoon', requires = 'nvim-lua/plenary.nvim' }
  },
  config = {
    display = { non_interactive = false },
  },
})
