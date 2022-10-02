if not pcall(require, 'rest-nvim') then
  return
end

require('rest-nvim').setup({
  -- Open request results in a horizontal split
  result_split_horizontal = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Highlight request on run
  highlight = {
    enabled = true,
    timeout = 150,
  },
  -- Jump to request line on run
  jump_to_request = false,
  yank_dry_run = true,
  show_url = true,
  show_http_info = false,
  show_headers = false,
})

vim.api.nvim_create_user_command('Request', 'tabnew | tcd ~/Projects/requests/ | enew', {})
