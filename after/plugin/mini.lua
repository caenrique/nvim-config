Cesar.require('mini.icons', {
  opts = {},
  after = function() MiniIcons.mock_nvim_web_devicons() end
})

Cesar.require('mini.statusline', {
  opts = {
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })

        local positionString = '%l:%v'
        local vstart, vend = vim.fn.getpos('v'), vim.fn.getpos('.')

        if vstart and vend then
          if vim.fn.mode() == 'v' then
            -- TODO: compute character count of the selection
            positionString = string.format('[Selection] %s:%s-%s:%s', vstart[2], vstart[3], vend[2], vend[3])
          elseif vim.fn.mode() == 'V' then
            positionString = string.format('[Line Selection] %s-%s (%s lines)', vstart[2], vend[2],
              math.abs(vstart[2] - vend[2]) + 1)
          end
        end

        local section_git = function(args)
          local summary = vim.g.gitsigns_head
          if MiniStatusline.is_truncated(args.trunc_width) or summary == nil then return '' end
          return '' .. ' ' .. (summary == '' and '-' or summary)
        end

        local lsp_servers = function()
          local names = {}
          for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
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
          { hl = '', strings = { section_git({ trunc_width = 40 }) } },
          { hl = 'MiniStatuslineFilename', strings = { search() } },
          '%<', -- Mark general truncate point
          '%=', -- End left alignment
          { hl = 'NonText', strings = { positionString, '%p%%' } },
          { hl = '@diff.plus', strings = { lsp_servers() } },
        })
      end,
    },
    use_icons = vim.g.have_nerd_font,
  },
  after = function()
    vim.api.nvim_create_autocmd('ModeChanged', {
      command = 'redrawstatus',
    })
  end,
})
