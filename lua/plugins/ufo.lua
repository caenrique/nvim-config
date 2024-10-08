return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  opts = {
    provider_selector = function(_, filetype, _)
      local filetype_mapping = {
        scala = { "lsp" },
        lua = { "lsp" },
        typescript = { "lsp" },
      }
      return filetype_mapping[filetype] or ""
    end,
  },
}
