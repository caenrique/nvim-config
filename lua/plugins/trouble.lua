return {
  "folke/trouble.nvim",
  enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    cycle_results = false, -- cycle item list when reaching beginning or end of list
    height = 15,
    padding = false,
    severity = vim.diagnostic.severity.ERROR,
    action_keys = { -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      close = "q", -- close the list
      cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r", -- manually refresh
      jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" }, -- open buffer in new split
      open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
      open_tab = { "<c-t>" }, -- open buffer in new tab
      jump_close = { "o" }, -- jump to the diagnostic and close the list
      toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
      switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
      toggle_preview = "P", -- toggle auto_preview
      hover = "K", -- opens a small popup with the full multiline message
      preview = "p", -- preview the diagnostic location
      open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
      close_folds = { "zM", "zm" }, -- close all folds
      open_folds = { "zR", "zr" }, -- open all folds
      toggle_fold = { "zA", "za" }, -- toggle fold of current file
      previous = "k", -- previous item
      next = "j", -- next item
      help = "?", -- help menu
    },
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
  },
  keys = {
    { "<leader>qw", "<cmd>Trouble workspace_diagnostics<cr>" },
    { "<leader>qq", "<cmd>Trouble quickfix<cr>" },
  },
}
