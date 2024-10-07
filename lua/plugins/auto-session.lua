return {
  "rmagatti/auto-session",
  dev = false,
  config = function()
    local function closeBuffers()
      local bufTypes = { "terminal", "nofile" }

      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
        if vim.tbl_contains(bufTypes, buftype) then
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end
      end
    end

    local function wipe_jump_list()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        vim.api.nvim_win_call(win, function()
          vim.cmd("clearjumps")
        end)
      end
    end

    vim.opt.sessionoptions = {
      "winsize",
      "localoptions",
    }

    require("auto-session").setup({
      log_level = "warn",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      pre_save_cmds = { closeBuffers },
      post_restore_cmds = { wipe_jump_list },
      no_restore_cmds = {
        function()
          if vim.fn.argv(0) == "" then
            require("telescope").extensions["recent-files"].recent_files()
          end
        end,
      },
      auto_session_use_git_branch = false,
      auto_session_create_enabled = false,
    })
  end,
}
