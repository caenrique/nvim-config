Cesar.require('snacks', {
  opts = {
    -- input = { enabled = true },
    notifier = { timeout = 3000 },
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
    statuscolumn = {
      left = { 'mark', 'git' }, -- priority of signs on the left (high to low)
      right = { 'fold' }, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      -- refresh = 50, -- refresh at most every 50ms
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
  },
  after = function()
    vim.keymap.set('n', '<leader>N', Snacks.notifier.show_history, { desc = 'Notification History' })
    vim.keymap.set('n', '<leader>gbl', Snacks.git.blame_line, { desc = 'Blame line' })
    vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Browse file on Remote' })

    vim.ui.select = require('snacks').picker.select
  end
})
