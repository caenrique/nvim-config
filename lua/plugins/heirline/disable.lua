local M = {}

M.disable_statuscolumn = function(params)
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("Heirline", {}),
    callback = function(opts)
      local buf = opts.buf
      local buftype = vim.tbl_contains(params.buftype, vim.bo[buf].buftype)

      if buftype then
        vim.wo.statuscolumn = ""
        vim.wo.foldcolumn = "0"
      else
        vim.o.statuscolumn = "%{%v:lua.require'heirline'.eval_statuscolumn()%}"
      end
    end,
  })
end

return M
