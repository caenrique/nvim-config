return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    -- Lua
    local actions = require('diffview.actions')

    require('diffview').setup({
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      view = {
        default = {
          winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
        },
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
      keymaps = {
        diff3 = {
          -- Mappings in 3-way diff layouts
          { { 'n', 'x' }, '<C-h>', actions.diffget('ours'),
            { desc = 'Obtain the diff hunk from the OURS version of the file' } },
          { { 'n', 'x' }, '<C-l>', actions.diffget('theirs'),
            { desc = 'Obtain the diff hunk from the THEIRS version of the file' } },
          { 'n', 'g?', actions.help({ 'view', 'diff3' }), { desc = 'Open the help panel' } },
        },
      }
    })
  end,
  keys = {
    { '<leader>d', '<cmd>DiffviewOpen<CR>' }
  }
}
