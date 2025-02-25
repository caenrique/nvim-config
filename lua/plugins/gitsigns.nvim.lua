return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  enabled = true,
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        gitsigns.nav_hunk('next')
      end, { desc = 'Next Hunk' })

      map('n', '[c', function()
        gitsigns.nav_hunk('prev')
      end, { desc = 'Prev Hunk' })

      map('n', '<leader>K', function()
        require('gitsigns').preview_hunk_inline()
      end, { desc = 'Show hunk diff inline' })
    end,
  },
  specs = {
    {
      'utilyre/barbecue.nvim',
      name = 'barbecue',
      opts = {
        custom_section = function()
          local gitstatus = vim.b.gitsigns_status_dict or {}
          local add = gitstatus.added and '%#@diff.plus#+' .. gitstatus.added or ''
          local changed = gitstatus.changed and '%#@diff.delta#~' .. gitstatus.changed or ''
          local deleted = gitstatus.removed and '%#@diff.minus#-' .. gitstatus.removed or ''
          return add .. ' ' .. changed .. ' ' .. deleted
        end,
      },
    },
  },
  lazy = false,
}
