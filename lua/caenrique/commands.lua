local cmd = vim.api.nvim_create_user_command

cmd('Delete', function(args)
  vim.fn.delete(vim.api.nvim_buf_get_name(0))
  vim.cmd('bdelete' .. (args.bang and '!' or ''))
end, { bang = true })

-- cmd('MarkdownToJira', function()
--   vim.cmd('read !pandoc -f gfm -w jira')
-- end, {})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = 'postmortem-*.md',
  command = '0read ~/Notes/templates/postmortem.md',
  group = vim.api.nvim_create_augroup('templates', {}),
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = 'JIRA-*.md',
  command = '0read ~/Notes/templates/jira.md',
  group = 'templates',
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = 'PR-*.md',
  command = '0read ~/Notes/templates/PR.md',
  group = 'templates',
})
