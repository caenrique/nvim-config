return {
  'alvarosevilla95/luatab.nvim',
  'feline-nvim/feline.nvim',
  'kyazdani42/nvim-web-devicons',
  'lukas-reineke/indent-blankline.nvim',
  { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },
  'kevinhwang91/nvim-bqf',
  'TimUntersberger/neogit',
  'TC72/auto-session',
  { 'windwp/nvim-autopairs', config = true },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'saadparwaiz1/cmp_luasnip', 'L3MON4D3/LuaSnip', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path',
      'onsails/lspkind-nvim', 'hrsh7th/cmp-nvim-lsp-signature-help', 'hrsh7th/cmp-emoji', 'hrsh7th/cmp-nvim-lua',
      'petertriho/cmp-git' }
  },
  'ckipp01/stylua-nvim',
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  'sbdchd/neoformat',

  'tpope/vim-fugitive',
}
