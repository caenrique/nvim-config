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

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.icons').setup()
    require('mini.git').setup()
    require('mini.diff').setup()
    require('mini.bracketed').setup()

    -- require('mini.tabline').setup()

    -- Section for repository name under ~/Projects folder
    local section_projectname = function(args)
      local icon = ' '
      local cwd = vim.fn.getcwd(0)
      cwd = vim.fn.fnamemodify(cwd, ':~')

      local _, _, domain, org, dir = cwd:find('~/Projects/([^/]+)/([^/]+)/([^/]+)')

      if domain and org and dir then
        cwd = domain .. '/' .. org .. '/' .. dir
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
          -- local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          -- local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          -- local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local projectname = section_projectname()
          -- local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = '%l│%2v'
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { projectname } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFilename', strings = { lsp } },
            { hl = mode_hl, strings = { search, location } },
          })
        end,
      },
      use_icons = vim.g.have_nerd_font,
    })
    vim.o.laststatus = 3

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
  keys = {
    {
      '<leader>K',
      function()
        MiniDiff.toggle_overlay(0)
      end,
      desc = 'Toggle MiniDiff overlay',
    },
  },
}
