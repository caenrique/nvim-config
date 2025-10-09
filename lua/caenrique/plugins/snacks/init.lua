return {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = require('caenrique.plugins.snacks.dashboard'),
    -- explorer = { enabled = true },
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
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      indent = {
        hl = 'SnacksIndentBlank', ---@type string|string[] hl group for scopes
      },
      scope = {
        only_current = true, -- only show scope in the current window
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for scopes
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
      end,
    },
    input = { enabled = true },
    notifier = { timeout = 3000 },
    picker = require('caenrique.plugins.snacks.picker'),
    scope = { enabled = false },
    statuscolumn = require('caenrique.plugins.snacks.statuscolumn'),
    styles = require('caenrique.plugins.snacks.styles'),
  },
  keys = {
    -- Top Pickers & Explorer
    { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    -- { '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },
    -- { '<leader>E', function() Snacks.explorer.reveal() end, desc = 'File Explorer' },
    -- find
    { '<leader>f', function() Snacks.picker.files() end, desc = 'Find Files' },
    -- Grep
    { '<leader>sb', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<leader>sr', function() Snacks.picker.recent() end, desc = 'Recent' },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sc', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sN', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    -- Other
    { '<leader>N', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    { '<leader>gb', function() Snacks.gitbrowse() end, desc = 'Browse file on Remote' },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('indent_guides_disabled_in_markdown', { clear = true }),
      pattern = 'markdown',
      callback = function() vim.b.snacks_indent = false end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Create some toggle mappings
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
      end,
    })
  end,
}
