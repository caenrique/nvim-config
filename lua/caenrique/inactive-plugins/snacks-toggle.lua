-- lazy.nvim
return {
  'folke/snacks.nvim',
  opts = function(_, opts)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>ts')
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>tw')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>tL')
        Snacks.toggle.diagnostics():map('<leader>td')
        Snacks.toggle.line_number():map('<leader>tl')
        Snacks.toggle
          .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map('<leader>tc')
        Snacks.toggle.treesitter():map('<leader>tT')
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>tb')
        Snacks.toggle.indent():map('<leader>tg')
        Snacks.toggle.dim():map('<leader>tD')
        Snacks.toggle
          .new({
            name = 'File Info',
            get = function() return vim.g.fileInfoEnabled end,
            set = function(value) vim.g.fileInfoEnabled = value end,
          })
          :map('<leader>ti')
      end,
    })

    return opts
  end,
}
