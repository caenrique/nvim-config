Cesar.require('mini.icons', {
  opts = {},
  after = function() MiniIcons.mock_nvim_web_devicons() end
})

Cesar.require('lsp-progress', {
  opts = {
    spinner = { '', '', '', '', '', '', '', '' },
    console_log = true,
    format = function(client_messages)
      local width = 120
      local value = ''
      if #client_messages > 0 then
        if #client_messages[1] > width then
          value = string.sub(client_messages[1], 1, width - 3) .. '...'
        else
          value = client_messages[1]
        end
      end

      if #client_messages > 1 then
        value = value .. '[' .. tostring(#client_messages - 1) .. ' more]'
      end
      return value
    end,
  },
  after = function()
    -- listen lsp-progress event and refresh lualine
    local group = vim.api.nvim_create_augroup('status-line-refresh-progress-messages', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      group = group,
      pattern = 'LspProgressStatusUpdated',
      callback = function() vim.cmd.redrawstatus() end,
    })
  end,
})

Cesar.require('mini.statusline', {
  opts = {
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local lsp_servers = function()
          local names = {}
          for _, server in pairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
            table.insert(names, server.name)
          end

          return #names > 0 and ' ' .. table.concat(names, ' ') or ''
        end
        local search = function()
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          if search == '' then
            return search
          else
            return 'Seach results: ' .. search
          end
        end

        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          -- { hl = '', strings = { gitsigns() } },
          { hl = '@diff.plus', strings = { lsp_servers() } },
          '%<', -- Mark general truncate point
          Cesar.with('lsp-progress', {
            callback = function(M) return { hl = 'MiniStarterInactive', strings = { M.progress() } } end,
            default = {}
          }),
          '%=', -- End left alignment
          { hl = '', strings = { git } },
          { hl = 'MiniStatuslineFilename', strings = { search() } },
        })
      end,
    },
    use_icons = vim.g.have_nerd_font,
  }
})

Cesar.require('mini.pick', {
  opts = {
    mappings = {
      quickfix = {
        char = "<C-q>",
        func = function()
          local all_items = MiniPick.get_picker_items()
          local marked = MiniPick.get_picker_matches().marked
          local choose = vim.tbl_isempty(marked) and all_items or marked
          MiniPick.default_choose_marked(choose, { list_type = "quickfix" })
        end,
      },
    },
  },
  after = function()
    vim.keymap.set('n', '<leader>/', MiniPick.builtin.grep_live, { desc = 'Grep files' })

    vim.keymap.set('n', '<leader>f', MiniPick.builtin.files, { desc = 'Find files' })
  end,
})
