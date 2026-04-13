Cesar.require('neogit', {
  opts = {
    disable_context_highlighting = true,
    process_spinner = false,
    commit_date_format = vim.fn.strftime('%c'),
    log_date_format = vim.fn.strftime('%c'),
    auto_refresh = true,
    -- kind = 'split_below',
    kind = 'tab',
    git_services = {
      ['github.com'] = {
        pull_request = 'https://${host}/${owner}/${repository}/compare/${branch_name}?expand=1',
        commit = 'https://${host}/${owner}/${repository}/commit/${oid}',
        tree = 'https://${host}/${owner}/${repository}/tree/${branch_name}',
      },
      ['ghe.siriusxm.com'] = {
        pull_request = 'https://${host}/${owner}/${repository}/compare/${branch_name}?expand=1',
        commit = 'https://${host}/${owner}/${repository}/commit/${oid}',
        tree = 'https://${host}/${owner}/${repository}/tree/${branch_name}',
      },
    },
    integrations = {
      snacks = true,
      diffview = true,
    },
    console_timeout = 5000,
    commit_editor = {
      kind = 'auto',
      show_staged_diff = false,
    },
    commit_order = '',
  },
  after = function()
    vim.keymap.set('n', '<leader>gs', require('neogit').open, { desc = 'Git status buffer' })
  end
})


Cesar.require('gitsigns', {
  opts = {
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 10000,
      use_focus = true,
    },
    current_line_blame_formatter = '  <summary>, <author>, <author_time:%R>',
    -- signs_staged_enable = false,
    -- culhl = true,
    gh = true,
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        gitsigns.nav_hunk('next', { target = 'all' })
      end, { desc = 'Next Hunk' })

      map('n', '[c', function()
        gitsigns.nav_hunk('prev', { target = 'all' })
      end, { desc = 'Prev Hunk' })

      map('n', '<leader>K', function() require('gitsigns').preview_hunk_inline() end, { desc = 'Show hunk diff inline' })

      -- Hunk Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[H]unk [S]tage' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[H]unk [R]reset' })
      map('x', '<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = '[H]unk [S]tage' })
      map('x', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = '[H]unk [R]reset' })

      -- Blame
      map('n', '<leader>gbc', function()
        local blame = vim.b.gitsigns_blame_line_dict
        if blame and blame.sha then
          require('gitsigns').show_commit(blame.sha, 'vsplit', function()
            local commit_bufnr = vim.api.nvim_get_current_buf()
            vim.opt_local.number = false
            vim.opt_local.wrap = false
            vim.keymap.set({ 'n', 'v', 'x' }, 'q', '<C-W>q', { desc = 'Close current window', buffer = commit_bufnr })
          end)
        end
      end, { desc = 'Blame commit in split window' })

    end,
  }
})

-- Cesar.require('codediff', {
--   opts = {
--     diff = {
--       layout = 'inline',
--       compute_moves = true,
--     },
--     explorer = {
--       view_mode = 'tree'
--     },
--     keymaps = {
--       view = {
--         -- toggle_explorer = '<leader>e',
--         toggle_layout = '<M-l>'
--       },
--       explorer = {
--         toggle_layout = '<M-l>',
--         -- toggle_explorer = '<leader>e',
--         -- toggle_staged = '<tab>',
--       },
--     },
--   },
--   after = function()
--     -- This is not working. Presumably because the plugin re-applies original window options
--     -- Need to investigate more
--     vim.api.nvim_create_autocmd("User", {
--       pattern = "CodeDiffOpen",
--       callback = function(args)
--         for _, win in ipairs(vim.api.nvim_tabpage_list_wins(args.data.tabpage)) do
--           vim.wo[win].cursorline = false
--           vim.wo[win].signcolumn = 'no'
--           -- vim.wo[win].virtualedit = 'all'
--         end
--       end,
--     })
--
--     -- vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff --inline<CR>', { desc = 'Open Diff view' })
--   end,
-- })

local inlay_hint_last_state = {}
Cesar.require('diffview', {
  opts = {
    hooks = {
      diff_buf_read = function(buf, _)
        vim.opt_local.wrap = false
        vim.b[buf].snacks_indent = false
        inlay_hint_last_state[buf] = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
        vim.lsp.inlay_hint.enable(false, { bufnr = buf })
      end,
      view_enter = function()
        vim.print('View Enter')
        inlay_hint_last_state = {}
        Cesar.with('gitsigns', { callback = function(gitsigns) gitsigns.toggle_signs(false) end })
      end,
      view_leave = function()
        for buf, state in pairs(inlay_hint_last_state) do
          if vim.api.nvim_buf_is_valid(buf) then
            vim.lsp.inlay_hint.enable(state, { bufnr = buf })
          end
        end
        Cesar.with('gitsigns', { callback = function(gitsigns) gitsigns.toggle_signs(true) end })
      end,
      view_opened = function(view)
        local utils = require('caenrique.tbl_utils')
        local function post_layout()
          utils.tbl_ensure(view, 'winopts.diff2.a')
          utils.tbl_ensure(view, 'winopts.diff2.b')
          -- left
          view.winopts.diff2.a = utils.tbl_union_extend(view.winopts.diff2.a, {
            winhl = {
              'DiffChange:DiffDelete',
              'DiffText:GitSignsDeleteInline',
            },
          })
          -- right
          view.winopts.diff2.b = utils.tbl_union_extend(view.winopts.diff2.b, {
            winhl = {
              'DiffChange:DiffAdd',
              'DiffText:GitSignsAddInline',
            },
          })
        end

        view.emitter:on('post_layout', post_layout)
        post_layout()
      end,
    }, -- See ':h diffview-config-hooks'
    enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
    view = {
      default = {
        winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
        -- Config for changed files, and staged files in diff views.
        layout = 'diff2_horizontal',
        disable_diagnostics = true,
      },
      merge_tool = {
        layout = 'diff1_plain',
      },
    },
    default_args = {
      DiffviewOpen = { '--untracked-files=no', '--imply-local' },
      DiffviewFileHistory = { '--base=LOCAL' },
    },
    file_panel = {
      listing_style = 'list', -- One of 'list' or 'tree'
      win_config = { -- See |diffview-config-win_config|
        position = 'left',
        width = 50,
        win_opts = {},
      },
    },
    keymaps = {
      file_panel = {
        { 'n', '<leader>e', require('diffview.actions').toggle_files, { desc = 'Toggle the file panel.' } },
        { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
        -- { 'n', '<tab>', require('diffview.actions').toggle_stage_entry },
      },
      file_history_panel = {
        { 'n', '<leader>e', require('diffview.actions').toggle_files, { desc = 'Toggle the file panel.' } },
        { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
      },
      view = {
        -- Find how to make these silent
        { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
        { 'n', '<tab>', require('diffview.actions').select_next_entry,
          { desc = 'Open the diff for the next file', silent = true } },
        {
          'n',
          '<s-tab>',
          require('diffview.actions').select_prev_entry,
          { desc = 'Open the diff for the previous file', silent = true },
        },
        { 'n', '<C-[>', require('diffview.actions').prev_conflict },
        { 'n', '<C-]>', require('diffview.actions').next_conflict },
        { 'n', '<leader>o', require('diffview.actions').conflict_choose('ours') },
        { 'n', '<leader>t', require('diffview.actions').conflict_choose('theirs') },
        { 'n', '<leader>b', require('diffview.actions').conflict_choose('base') },
        { 'n', '<leader>a', require('diffview.actions').conflict_choose('all') },
        { 'n', '<leader>x', require('diffview.actions').conflict_choose('none') },
        { 'n', '<leader>O', require('diffview.actions').conflict_choose_all('ours') },
        { 'n', '<leader>T', require('diffview.actions').conflict_choose_all('theirs') },
        { 'n', '<leader>B', require('diffview.actions').conflict_choose_all('base') },
        { 'n', '<leader>A', require('diffview.actions').conflict_choose_all('all') },
        { 'n', '<leader>X', require('diffview.actions').conflict_choose_all('none') },
        { 'n', '<leader>e', require('diffview.actions').toggle_files, { desc = 'Toggle the file panel.' } },
      },
    },
  },
  after = function()
    vim.api.nvim_create_user_command(
      'DiffPullRequest',
      'DiffviewOpen origin/HEAD...HEAD --imply-local --minimal --no-indent-heuristic',
      {}
    )
    vim.api.nvim_create_user_command(
      'DiffPullRequestByCommit',
      'DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges',
      {}
    )

    vim.keymap.set('n', '<leader>gd', '<cmd>silent DiffviewOpen<CR>', { desc = '[G]it [D]iff' })
    vim.keymap.set('n', '<leader>gfh', '<cmd>silent DiffviewFileHistory<CR>', { desc = '[G]it [F]ile [H]istory' })
    vim.keymap.set('n', '<leader>gD', '<cmd>silent DiffPullRequest<CR>', { desc = '[G]it [D]iff (pull request)' })
    vim.keymap.set('n', '<leader>gcd', '<cmd>silent DiffPullRequestByCommit<CR>',
      { desc = '[G]it [C]ommit by commit [D]iff (pull request)', })
  end,
})
