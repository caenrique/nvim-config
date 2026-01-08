return {
  'ashot/vim-pr-comments',
  enabled = false,
  init = function()
    vim.g.pr_comments_max_length = 500 -- Maximum comment length in quickfix (default: 300 chars)
    vim.g.pr_comments_show_full = 1 -- Show full comments without truncation (default: 0)
    vim.g.pr_comments_wrap_quickfix = 1 -- Enable line wrapping in quickfix window (default: 0)
    vim.g.pr_comments_show_resolved = 0 -- Show resolved comments by default (default: 0 - hidden)
  end,
}
