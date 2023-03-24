local cmd = vim.api.nvim_create_user_command

cmd('Delete', function(args)
  vim.fn.delete(vim.api.nvim_buf_get_name(0))
  vim.cmd('bdelete' .. (args.bang and '!' or ''))
end, { bang = true })
