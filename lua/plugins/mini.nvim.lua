return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.) - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.icons').setup()
    -- require('mini.git').setup()
    -- require('mini.diff').setup()
    require('mini.bracketed').setup({
      comment = { suffix = '', options = {} },
    })

    -- require('mini.map').setup({
    --   window = {
    --     winblend = 90,
    --   },
    --   integrations = {
    --     require('mini.map').gen_integration.builtin_search(),
    --     require('mini.map').gen_integration.diagnostic(),
    --     -- require('mini.map').gen_integration.diff(),
    --   },
    -- })

    -- require('mini.tabline').setup()

    -- Section for repository name under ~/Projects folder
    local section_projectname = function(args)
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
      return icon .. cwd .. trail
    end

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
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
            return ' ' .. table.concat(names, ' ')
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
