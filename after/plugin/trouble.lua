if not pcall(require, 'trouble') then
  return
end

require('trouble').setup({
  signs = {
    error = '',
    warning = '',
    hint = '',
    information = '',
    other = '﫠',
  },
  use_diagnostic_signs = false,
  auto_close = true,
})

