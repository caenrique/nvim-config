return {
  prompt = ' ',
  sources = {},
  focus = 'input',
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      width = 90,
      sections = {
        { section = 'header' },
        { section = 'keys', icon = '󰘳 ', title = 'Keymaps', indent = 3, gap = 0, padding = 1 },
        {
          -- pane = 2,
          icon = ' ',
          desc = 'Browse Repo',
          padding = 1,
          key = 'b',
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              icon = ' ',
              title = 'Open PRs',
              cmd = "gh pr list -L 5 --json title,createdAt --jq '.[] | [.title, (.createdAt | fromdate | strftime(\"%Y-%m-%d %H:%M UTC\"))] | @tsv' | awk -v FS='\\t' -v OFS='\\t' '{printf \"%-60s %-20s\\n\",substr($1, 1, 58),substr($2,1,20)}'",
              key = 'P',
              action = function()
                vim.fn.jobstart('gh pr list --web', { detach = true })
              end,
              height = 5,
              indent = 3,
            },
            {
              icon = ' ',
              title = 'Git Status',
              cmd = 'git --no-pager diff --stat -B -M -C',
              height = 10,
              indent = 2,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend('force', {
              -- pane = 2,
              section = 'terminal',
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
            }, cmd)
          end, cmds)
        end,
        { section = 'startup' },
      },
    },
    explorer = { enabled = true },
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
    notifier = {
      enabled = true,
      timeout = 3000,
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
              filename_first = false,
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
        preset = function()
          return vim.o.columns >= 160 and 'default' or 'vertical'
        end,
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
            { win = 'preview', title = '{preview}', height = 0.5, border = 'bottom' },
            { win = 'input', height = 1, border = 'none' },
            { win = 'list', border = 'top' },
          },
        },
      },
    },
    scope = { enabled = false },
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
    words = { enabled = false },
    styles = {
      terminal = {
        bo = {
          filetype = 'snacks_terminal',
        },
        wo = {},
        keys = {
          q = 'hide',
          gf = function(self)
            local f = vim.fn.findfile(vim.fn.expand('<cfile>'), '**')
            if f == '' then
              Snacks.notify.warn('No file under cursor')
            else
              self:hide()
              vim.schedule(function()
                vim.cmd('e ' .. f)
              end)
            end
          end,
          term_normal = {
            '<esc>',
            function(self)
              self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
              if self.esc_timer:is_active() then
                self.esc_timer:stop()
                vim.cmd('stopinsert')
              else
                self.esc_timer:start(200, 0, function() end)
                return '<esc>'
              end
            end,
            mode = 't',
            expr = true,
            desc = 'Double escape to normal mode',
          },
          toggle_terminal = {
            '<C-/>',
            function(self)
              Snacks.terminal()
            end,
            mode = 't',
            expr = true,
            desc = 'toggle terminal in terminal mode',
          },
        },
      },
    },
    gitbrowse = { enabled = true },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'File Explorer',
    },
    -- find
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    -- git
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git Log Line',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },
    {
      '<leader>gf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log File',
    },
    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search for Plugin Spec',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sR',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    -- LSP
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gI',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>sS',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'LSP Workspace Symbols',
    },
    -- Other
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>Z',
      function()
        Snacks.zen.zoom()
      end,
      desc = 'Toggle Zoom',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>n',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
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
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
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
