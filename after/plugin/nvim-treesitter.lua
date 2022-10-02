if not pcall(require, 'nvim-treesitter') then
  return
end

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

local group = vim.api.nvim_create_augroup("tree-sitter", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = { "scala", "sbt", "java", "lua", "json" },
  callback = "normal zx",
  group = group,
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'scala', 'python', 'lua', 'json', 'bash', 'java', 'dockerfile', 'markdown', 'norg', 'http' },
  sync_install = false,
  indent = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  rainbow = {
    enable = false,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
})
