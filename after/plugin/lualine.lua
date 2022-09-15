if not pcall(require, 'lualine') then
  return
end

local lualine = require('lualine')

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_if_narrow = function()
    return vim.fn.winwidth(0) > 100
  end,
  show_if_narrow = function()
    return vim.fn.winwidth(0) <= 100
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  lsp_is_active = function()
    local clients = vim.lsp.get_active_clients()
    return next(clients) ~= nil
  end,
}

-- Config
local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = 'tokyonight',
    disabled_filetypes = { 'Trouble', 'NvimTree', 'help', 'terminal' },
  },
  sections = {
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
        cond = function()
          return conditions.buffer_not_empty() and conditions.hide_if_narrow()
        end,
        color = { gui = 'bold' },
      },
      {
        'filename',
        path = 0,
        cond = function()
          return conditions.buffer_not_empty() and conditions.show_if_narrow()
        end,
        color = { gui = 'bold' },
      },
    },
    lualine_x = {
      { "vim.g['metals_status']" },
      {
        function()
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return ''
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return ''
        end,
        icon = '',
        color = { gui = 'bold' },
        cond = conditions.lsp_is_active,
      },
      {
        'diff',
        symbols = { added = ' ', modified = '柳', removed = ' ' },
        cond = conditions.hide_if_narrow,
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {
      {
        'filename',
        cond = conditions.buffer_not_empty,
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        mode = 2,
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        -- symbols = { error = ' ', warn = ' ', info = ' ' },
      },
      {
        function()
          local path = vim.fn.split(vim.fn.getcwd(), '/')
          return path[#path]
        end,
        icon = '',
        color = { gui = 'bold' },
        cond = conditions.hide_if_narrow,
      },
      {
        'branch',
        icon = '',
        cond = function()
          return conditions.check_git_workspace() and conditions.hide_if_narrow()
        end,
        color = { gui = 'bold' },
      },
    },
  },
  extensions = { 'nvim-tree' },
}

lualine.setup(config)
