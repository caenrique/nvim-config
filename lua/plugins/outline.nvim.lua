return {
  'hedyhli/outline.nvim',
  enabled = false,
  config = function()
    -- Example mapping to toggle outline
    vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })

    require('outline').setup {
      -- Options for outline guides which help show tree hierarchy of symbols
      guides = {
        enabled = true,
      },

      symbol_folding = {
        -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
        autofold_depth = false,
      },
    }
  end,
}
