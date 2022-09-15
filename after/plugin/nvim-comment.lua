if not pcall(require, 'nvim_comment') then
  return
end

require('nvim_comment').setup({
  line_mapping = '\\\\',
  operator_mapping = '\\',
})
