Cesar.require('mini.icons', {
  opts = {},
  after = function() MiniIcons.mock_nvim_web_devicons() end
})

Cesar.require('mini.statusline', {
  opts = {
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })

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
          { hl = '@diff.plus', strings = { lsp_servers() } },
          { hl = 'MiniStatuslineFilename', strings = { search() } },
          '%<', -- Mark general truncate point
          '%=', -- End left alignment
          { hl = '', strings = { section_git({ trunc_width = 40 }) } },
        })
      end,
    },
    use_icons = vim.g.have_nerd_font,
  }
})

Cesar.require('mini.pick', {
  enable = false,
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

    MiniPick.setup()

    local files = function()
      MiniPick.builtin.files({}, {
        source = {
          show = function(bufid, items_to_show, query) MiniPick.default_show(bufid, items_to_show, query,
              { use_icons = true, item_to_string =
              function(x)
                local file, dir = vim.fs.basename(x), vim.fs.dirname(x)
                local text = dir ~= '.' and string.format('%s %s', file, dir) or file
                local highlights = {
                  { hl = 'MiniPickNormal', from = 0, to = file:len() },
                }

                if text ~= file then
                  table.insert(highlights, { hl = 'NonText', from = file:len() + 1, to = text:len() })
                end

                return {
                  text = text,
                  highlights = highlights,
                }
              end })
          end
        }
      })
    end

    vim.keymap.set('n', '<leader>/', MiniPick.builtin.grep_live, { desc = 'Grep files' })
    vim.keymap.set('n', '<leader>f', MiniPick.builtin.files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>of', files, { desc = 'Experimental Find files' })
  end,
})
