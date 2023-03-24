return {
  'TC72/auto-session',
  config = function()
    local function closeBuffers()
      local bufTypes = { 'terminal', 'nofile' }

      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
        if vim.tbl_contains(bufTypes, buftype) then
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end
      end
    end

    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      pre_save_cmds = { closeBuffers }
    }
  end
}
