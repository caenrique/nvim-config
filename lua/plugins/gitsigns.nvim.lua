return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  enabled = true,
  opts = {
    attach_to_untracked = true,
    signs = {
      add = { text = '▌' }, -- adjust these so they are not so thick due to my font
      change = { text = '▌' }, -- adjust these so they are not so thick due to my font
      delete = { text = '▁' },
      topdelete = { text = '▔' },
      -- changedelete = { text = '~' },
      untracked = { text = '╎' },
    },
    signs_staged = {
      add = { text = '▌' }, -- adjust these so they are not so thick due to my font
      change = { text = '▌' }, -- adjust these so they are not so thick due to my font
      delete = { text = '▁' },
      topdelete = { text = '▔' },
      -- changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 10000,
      use_focus = true,
    },
    -- signs_staged_enable = false,
    -- culhl = true,
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
          local add = gitstatus.added and gitstatus.added ~= 0 and '%#@diff.plus#+' .. gitstatus.added .. ' ' or ''
          local changed = gitstatus.changed and gitstatus.changed ~= 0 and '%#@diff.delta#~' .. gitstatus.changed .. ' ' or ''
          local deleted = gitstatus.removed and gitstatus.removed ~= 0 and '%#@diff.minus#-' .. gitstatus.removed .. ' ' or ''
          return add .. changed .. deleted
        end,
      },
    },
  },
  lazy = false,
}
