return {
  provider = function()
    local path = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(path, ":t:r")
    return vim.fn.pathshorten(filename)
  end,
}
