return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    -- require('mini.ai').setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.) - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.icons').setup()
    require('mini.bracketed').setup({
      comment = { suffix = '', options = {} },
    })

    -- Open Snacks.explorer action to be assigned to a mouse click event
    _G.openExplorerAction = function(_, _, button, _)
      if button == 'l' then
        Snacks.explorer()
      end
    end

    -- Open vim.cmd.LspInfo action to be assigned to a mouse click event
    _G.openLspInfo = function(_, _, button, _)
      if button == 'l' then
        vim.cmd.LspInfo()
      end
    end

    local section_projectname = function(_)
      local icon = ' '
      local cwd = vim.fn.getcwd(0)
      cwd = vim.fn.fnamemodify(cwd, ':~')

      local _, _, domain, org, dir = cwd:find('~/Projects/([^/]+)/([^/]+)/([^/]+)')

      if domain and org and dir then
        if domain == 'ghe.siriusxm.com' then
          cwd = org .. '/' .. dir
        else
          cwd = domain .. '/' .. org .. '/' .. dir
        end
      end

      local trail = cwd:sub(-1) == '/' and '' or '/'
      local clickRegionStart = '%@v:lua.openExplorerAction@'
      local clickRegionEnd = '%X'
      return clickRegionStart .. icon .. cwd .. trail .. clickRegionEnd
    end

    local statusline = require('mini.statusline')
    -- set use_icons to true if you have a Nerd Font
    statusline.setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diagnostics = MiniStatusline.section_diagnostics({
            trunc_width = 75,
          })
          local projectname = section_projectname()
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })

          local lsp_servers = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
              table.insert(names, server.name)
            end
            local clickRegionStart = '%@v:lua.openLspInfo@'
            local clickRegionEnd = '%X'

            return #names > 0 and clickRegionStart .. ' ' .. table.concat(names, ' ') .. clickRegionEnd or ''
          end
          local location = 'Ln %l, Col %v'
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
            { hl = 'MiniStatuslineDevinfo', strings = { git } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { projectname } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFilename', strings = { search() } },
            { hl = '@diff.plus', strings = { lsp_servers() } },
            { hl = '@text.note', strings = { diagnostics } },
            { hl = 'MiniStatuslineFileinfo', strings = { location, fileinfo } },
          })
        end,
      },
      use_icons = vim.g.have_nerd_font,
    })
    vim.o.laststatus = 3

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
