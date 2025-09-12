return {
  width = 90,
  preset = {
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
      { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.picker.smart()' },
      -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      { icon = ' ', key = 'b', desc = 'Browse Repo', action = function() Snacks.gitbrowse() end },
    },
  },
  sections = {
    { section = 'header' },
    { section = 'keys', icon = '󰘳 ', title = 'Keymaps', indent = 3, gap = 0, padding = 1 },
    function()
      local in_git = Snacks.git.get_root() ~= nil
      local cmds = {
        {
          icon = ' ',
          title = 'Open PRs',
          cmd = "gh pr list -L 5 --json title,createdAt --jq '.[] | [.title, (.createdAt | fromdate | strftime(\"%Y-%m-%d %H:%M UTC\"))] | @tsv' | awk -v FS='\\t' -v OFS='\\t' '{printf \"%-60s %-20s\\n\",substr($1, 1, 58),substr($2,1,20)}'",
          key = 'P',
          action = function() vim.fn.jobstart('gh pr list --web', { detach = true }) end,
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
}
