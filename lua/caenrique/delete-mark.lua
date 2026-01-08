return {
  delete_marks = function()
    local global_marks = vim.fn.getmarklist()
    local bufnr = vim.api.nvim_get_current_buf()
    local local_marks = vim.fn.getmarklist(bufnr)

    local cursor = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor[1]
    local current_buffer = vim.api.nvim_get_current_buf()

    local all_marks = require('caenrique.tbl_utils').vec_union(global_marks, local_marks)

    for _, mark in ipairs(all_marks) do
      local buffer = mark.pos[1]
      local line = mark.pos[2]

      if buffer == current_buffer and line == current_line then
        vim.notify('Deleting mark ' .. mark.mark:sub(2))
        vim.cmd.delmarks(mark.mark:sub(2))
      end
    end
  end,
}
