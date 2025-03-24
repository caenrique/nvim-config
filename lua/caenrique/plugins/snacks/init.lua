return {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = require('caenrique.plugins.snacks.dashboard'),
    explorer = { enabled = true },
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
      filter = function(buf) return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == '' end,
    },
    input = { enabled = true },
    notifier = { timeout = 3000 },
    picker = require('caenrique.plugins.snacks.picker'),
    scope = { enabled = false },
    statuscolumn = require('caenrique.plugins.snacks.statuscolumn'),
    styles = require('caenrique.plugins.snacks.styles'),
    words = { enabled = false },
  },
  keys = {
    -- Top Pickers & Explorer
    { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    { '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },
    -- find
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Find Config File' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
    { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },
    -- Grep
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
    { '<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
    { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },
    -- LSP
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
    {
      '<leader>sws',
      function()
        Snacks.picker.lsp_workspace_symbols({
          live = false,
          matcher = {
            fuzzy = false,
            filename_bonus = false,
            file_pos = false,
          },
        })
      end,
      desc = 'LSP Workspace Symbols',
    },
    {
      '<leader>sws',
      function()
        Snacks.picker.lsp_workspace_symbols({
          live = false,
          matcher = {
            fuzzy = false,
            filename_bonus = false,
            file_pos = false,
          },
        })
      end,
      desc = 'LSP Workspace Symbols',
    },
    -- Other
    { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
    { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
    { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
    { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
    {
      '<leader>N',
      desc = 'Neovim News',
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        })
      end,
    },
    {
      '<leader>sn',
      desc = '[S]earch [N]otes',
      function() Snacks.picker.files({ cwd = '/Users/cesar.enrique/Notes/', title = 'Find Notes' }) end,
    },
    {
      '<leader>sgn',
      desc = '[S]earch [G]rep [N]otes',
      function() Snacks.picker.grep({ cwd = '/Users/cesar.enrique/Notes/', title = 'Grep Notes' }) end,
    },
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
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
        Snacks.toggle.diagnostics():map('<leader>ud')
        Snacks.toggle.line_number():map('<leader>ul')
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>uc')
        Snacks.toggle.treesitter():map('<leader>uT')
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
        Snacks.toggle.inlay_hints():map('<leader>uh')
        Snacks.toggle.indent():map('<leader>ug')
        Snacks.toggle.dim():map('<leader>uD')
      end,
    })
  end,
}
