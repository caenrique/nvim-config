return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- require('mini.surround').setup()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    vim.g.fileInfoEnabled = false

    require('mini.statusline').setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })

          local gitsigns = function()
            local gitstatus = vim.b.gitsigns_status_dict or {}
            local add = gitstatus.added and gitstatus.added ~= 0 and '%#@diff.plus#+' .. gitstatus.added .. ' ' or ''
            local changed = gitstatus.changed
                and gitstatus.changed ~= 0
                and '%#@diff.delta#~' .. gitstatus.changed .. ' '
              or ''
            local deleted = gitstatus.removed
                and gitstatus.removed ~= 0
                and '%#@diff.minus#-' .. gitstatus.removed .. ' '
              or ''
            return add .. changed .. deleted
          end
          local diagnostics = MiniStatusline.section_diagnostics({
            trunc_width = 75,
          })

          local function fileinfo()
            if vim.g.fileInfoEnabled == true then
              return ' ' .. MiniStatusline.section_fileinfo({ trunc_width = 120 })
            else
              return ''
            end
          end

          local lsp_servers = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
              table.insert(names, server.name)
            end

            return #names > 0 and ' ' .. table.concat(names, ' ') or ''
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

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = '', strings = { git } },
            '%<', -- Mark general truncate point
            { hl = '', strings = { gitsigns() } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFilename', strings = { search() } },
            { hl = '@diff.plus', strings = { lsp_servers() } },
            { hl = '@text.note', strings = { diagnostics } },
            {
              hl = 'MiniStatuslineFileinfo',
              strings = { location, fileinfo() },
            },
          })
        end,
      },
      use_icons = vim.g.have_nerd_font,
    })
    vim.o.laststatus = 3
  end,
}
