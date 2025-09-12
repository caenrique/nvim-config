return {
  'HawkinsT/pathfinder.nvim', -- improved gf/gF over multiline links
  opts = {
    remap_default_keys = false,
  },
  keys = {
    { '<leader>gx', function() require('pathfinder').select_url() end },
  },
}
