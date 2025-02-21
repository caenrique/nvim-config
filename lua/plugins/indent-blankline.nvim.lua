return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      injected_languages = false,
      show_exact_scope = true,
      highlight = { 'Function', 'Label' },
      priority = 500,
      include = {
        node_type = {
          scala = { 'for_expression', 'match_expression', 'case_clause' },
        },
      },
    },
    exclude = {
      filetypes = {
        'dashboard',
      },
    },
  },
}
