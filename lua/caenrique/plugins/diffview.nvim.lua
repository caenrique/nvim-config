return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local actions = require('diffview.actions')

    require('diffview').setup({
      hooks = {
        diff_buf_read = function()
          vim.opt_local.wrap = false
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
                'DiffText:DiffDeleteText',
              },
            })
            -- right
            view.winopts.diff2.b = utils.tbl_union_extend(view.winopts.diff2.b, {
              winhl = {
                'DiffChange:DiffAdd',
                'DiffText:DiffAddText',
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
        },
        merge_tool = {
          layout = 'diff3_mixed',
        },
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
          { 'n', '<C-n>', actions.toggle_files, { desc = 'Toggle the file panel.' } },
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
          { 'n', '<tab>', actions.toggle_stage_entry },
        },
        file_history_panel = {
          { 'n', '<C-n>', actions.toggle_files, { desc = 'Toggle the file panel.' } },
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
        },
        view = {
          -- Find how to make these silent
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { silent = true } },
          { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file', silent = true } },
          {
            'n',
            '<s-tab>',
            actions.select_prev_entry,
            { desc = 'Open the diff for the previous file', silent = true },
          },
          { 'n', '<C-[>', actions.prev_conflict },
          { 'n', '<C-]>', actions.next_conflict },
          { 'n', '<C-n>', actions.toggle_files },
          { 'n', '<leader>o', actions.conflict_choose('ours') },
          { 'n', '<leader>t', actions.conflict_choose('theirs') },
          { 'n', '<leader>b', actions.conflict_choose('base') },
          { 'n', '<leader>a', actions.conflict_choose('all') },
          { 'n', '<leader>x', actions.conflict_choose('none') },
          { 'n', '<leader>O', actions.conflict_choose_all('ours') },
          { 'n', '<leader>T', actions.conflict_choose_all('theirs') },
          { 'n', '<leader>B', actions.conflict_choose_all('base') },
          { 'n', '<leader>A', actions.conflict_choose_all('all') },
          { 'n', '<leader>X', actions.conflict_choose_all('none') },
        },
      },
    })

    vim.api.nvim_create_user_command('DiffPullRequest', 'DiffviewOpen origin/HEAD...HEAD --imply-local --minimal --no-indent-heuristic', {})
    vim.api.nvim_create_user_command(
      'DiffPullRequestByCommit',
      'DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges',
      {}
    )
  end,
  keys = {
    { '<leader>gd', '<cmd>silent DiffviewOpen<CR>', desc = '[G]it [D]iff' },
    { '<leader>gfh', '<cmd>silent DiffviewFileHistory<CR>', desc = '[G]it [F]ile [H]istory' },
    { '<leader>gD', '<cmd>silent DiffPullRequest<CR>', desc = '[G]it [D]iff (pull request)' },
    { '<leader>gcd', '<cmd>silent DiffPullRequestByCommit<CR>', desc = '[G]it [C]ommit by commit [D]iff (pull request)' },
  },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffPullRequest', 'DiffPullRequestByCommit' },
}
