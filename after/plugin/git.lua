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
      map('n', ']c', function() gitsigns.nav_hunk('next') end, { desc = 'Next Hunk' })
      map('n', '[c', function() gitsigns.nav_hunk('prev') end, { desc = 'Prev Hunk' })
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

Cesar.require('codediff', {
  opts = {
    diff = {
      layout = 'inline',
      compute_moves = true,
    },
    explorer = {
      view_mode = 'tree'
    },
    keymaps = {
      view = {
        -- toggle_explorer = '<leader>e',
        toggle_layout = '<M-l>'
      },
      explorer = {
        toggle_layout = '<M-l>',
        -- toggle_explorer = '<leader>e',
        -- toggle_staged = '<tab>',
      },
    },
  },
  after = function()
    -- This is not working. Presumably because the plugin re-applies original window options
    -- Need to investigate more
    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffOpen",
      callback = function(args)
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(args.data.tabpage)) do
          vim.wo[win].cursorline = false
          vim.wo[win].signcolumn = 'no'
          vim.wo[win].virtualedit = 'all'
        end
      end,
    })

    vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff --inline<CR>', { desc = 'Open Diff view' })
  end,
})
