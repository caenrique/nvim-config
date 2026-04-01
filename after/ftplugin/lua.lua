local ok, lazydev = pcall(require, 'lazydev')

if ok then
  lazydev.setup({
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      'lazy.nvim',
      'snacks.nvim',
      'quicker.nvim',
      'render-markdown.nvim',
      'nvim-dap-view',
      'smart-splits.nvim',
      -- 'wezterm-types',
    },
  })
end
