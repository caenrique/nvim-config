Cesar.require('snacks', {
  opts = {
    -- input = { enabled = true },
    -- notifier = { timeout = 3000 },
    -- scope = { enabled = false }, -- investigate this more. might be useful
    gitbrowse = {
      url_patterns = {
        ['ghe.siriusxm.com'] = {
          branch = '/tree/{branch}',
          file = '/blob/{branch}/{file}#L{line_start}-L{line_end}',
          permalink = '/blob/{commit}/{file}#L{line_start}-L{line_end}',
          commit = '/commit/{commit}',
        },
      },
    },
    indent = {
      enabled = true,
      indent = {
        enabled = true,
        hl = 'SnacksIndentBlank', ---@type string|string[] hl group for scopes
      },
      scope = {
        only_current = true, -- only show scope in the current window
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for scopes
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false
            and vim.b[buf].snacks_indent ~= false
            and vim.bo[buf].buftype == ''
            and vim.bo[buf].filetype ~= 'markdown' -- Disable in markdown buffers
            and vim.bo[buf].filetype ~= 'tvp' -- Disable in tvp buffers
      end,
    },
    picker = {
      sources = {
        grep = {
          finder = 'grep',
          regex = true,
          format = 'file',
          show_empty = true,
          live = true, -- live grep by default
          supports_live = true,
          formatters = {
            file = {
              filename_first = true,
              truncate = 40,
            },
          },
          layout = {
            hidden = {},
          },
        },
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 60,
        },
      },
      layout = {
        cycle = true,
        hidden = { 'preview' },
        --- Use the default layout or vertical if the window is too narrow
        preset = function() return vim.o.columns > 170 and 'default' or 'vertical' end,
      },
      layouts = {
        vertical = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.9,
            min_height = 30,
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'none' },
            { win = 'list', border = 'top' },
            { win = 'preview', title = '{preview}', height = 0.5, border = 'top' },
          },
        },
      },
    },
  },
  after = function()
    vim.keymap.set('n', '<leader>N', Snacks.notifier.show_history, { desc = 'Notification History' })
    vim.keymap.set('n', '<leader>gbl', Snacks.git.blame_line, { desc = 'Blame line' })
    vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Browse file on Remote' })

    -- Top Pickers
    vim.keymap.set('n', '<leader>f', function() Snacks.picker.files() end, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader><space>', function() Snacks.picker.resume() end, { desc = 'Smart Find Files' })
    vim.keymap.set('n', '<leader>sb', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
    vim.keymap.set({ 'x', 'v', 'n' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Grep selection' })
    vim.keymap.set('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
    vim.keymap.set('n', '<leader>sr', function() Snacks.picker.recent() end, { desc = 'Recent' })
    vim.keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
    vim.keymap.set('n', '<leader>sc', function() Snacks.picker.commands() end, { desc = 'Commands' })
    vim.keymap.set('n', '<leader>sN', function() Snacks.picker.notifications() end, { desc = 'Notification History' })
    vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
    vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
    vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
    vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
    vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
    vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
    vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })

    vim.ui.select = require('snacks').picker.select
  end
})
