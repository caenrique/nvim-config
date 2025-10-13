return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-telescope/telescope.nvim',
    -- OR 'ibhagwan/fzf-lua',
    'folke/snacks.nvim',
    -- 'nvim-tree/nvim-web-devicons',
  },
  opts = {
    picker = 'snacks', -- or "fzf-lua" or "snacks"
  },
}
