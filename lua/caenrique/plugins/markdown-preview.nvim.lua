return {
  {
    'iamcco/markdown-preview.nvim',
    enabled = false,
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = ':call mkdp#util#install()',
    init = function() vim.g.mkdp_browser = 'firefox' end,
  },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    opts = {
      theme = 'light',
      app = 'browser',
    },
    config = function(_, opts)
      require('peek').setup(opts)
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
  {},
}
