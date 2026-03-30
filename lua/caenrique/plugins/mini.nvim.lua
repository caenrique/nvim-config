return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  dependencies = {
    'linrongbin16/lsp-progress.nvim',
  },
  config = function()
    -- require('mini.surround').setup()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    vim.g.fileInfoEnabled = false

    require('lsp-progress').setup({
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
    })

    -- listen lsp-progress event and refresh lualine
    local group = vim.api.nvim_create_augroup('status-line-refresh-progress-messages', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      group = group,
      pattern = 'LspProgressStatusUpdated',
      callback = function() vim.cmd.redrawstatus() end,
    })

    require('mini.statusline').setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          -- local function fileinfo()
          --   if vim.g.fileInfoEnabled == true then
          --     return ' ' .. MiniStatusline.section_fileinfo({ trunc_width = 120 })
          --   else
          --     return ''
          --   end
          -- end

          local lsp_servers = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
              table.insert(names, server.name)
            end

            return #names > 0 and ' ' .. table.concat(names, ' ') or ''
          end

          local location = '%P, Ln %l, Col %v'

          local search = function()
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
            if search == '' then
              return search
            else
              return 'Seach results: ' .. search
            end
          end

          local progress = function() return require('lsp-progress').progress() end

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            -- { hl = '', strings = { gitsigns() } },
            { hl = '@diff.plus', strings = { lsp_servers() } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStarterInactive', strings = { progress() } },
            '%=', -- End left alignment
            { hl = '', strings = { git } },
            { hl = 'MiniStatuslineFilename', strings = { search() } },
            -- { hl = '@text.note', strings = { diagnostics } },
            -- {
            --   hl = 'MiniStatuslineFileinfo',
            --   strings = { location, fileinfo() },
            -- },
          })
        end,
      },
      use_icons = vim.g.have_nerd_font,
    })
    vim.o.laststatus = 3
  end,
}
