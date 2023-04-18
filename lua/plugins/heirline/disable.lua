local M = {}

M.disable_statuscolumn = function(params)
  local group = vim.api.nvim_create_augroup('Heirline', {})
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = params.filetype,
    callback = function()
      vim.wo.statuscolumn = ''
    end
  })

  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function(opts)
      local buf = opts.buf
      local buftype = vim.tbl_contains(params.buftype, vim.bo[buf].buftype)

      if buftype then
        vim.wo.statuscolumn = ''
      end
    end
  })
end

return M
