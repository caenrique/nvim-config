return {
  -- Decorated scrollbars for Neovim
  'lewis6991/satellite.nvim',
  enabled = false,
  opts = {
    excluded_filetypes = { 'neo-tree' },
    handlers = {
      gitsigns = {
        enable = false,
      },
    },
  },
}
