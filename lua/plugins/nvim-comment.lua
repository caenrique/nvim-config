return {
  'terrortylor/nvim-comment',
  name = 'nvim_comment',
  opts = {
    line_mapping = '\\\\',
    operator_mapping = '\\'
  },
  keys = {
    { '\\\\' },
    { '\\', mode = 'v' }
  }
}
