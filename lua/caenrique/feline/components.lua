local M = {}

local colors = require('caenrique.theme')

local rignt_sep = {
  str = ' ',
  hl = {
    fg = 'NONE',
    bg = colors.bg_statusline,
  },
}

M.vim_mode = {
  provider = {
    name = 'vi_mode',
    opts = {
      padding = 'center',
    },
  },
  hl = function()
    return {
      name = require('feline.providers.vi_mode').get_mode_highlight_name(),
      bg = require('feline.providers.vi_mode').get_mode_color(),
      fg = colors.bg_statusline,
      style = 'bold',
    }
  end,
  right_sep = rignt_sep,
  icon = '',
}

M.git_branch = {
  provider = 'git_branch',
  hl = {
    fg = 'white',
    bg = colors.bg_statusline,
    style = 'bold',
  },
  left_sep = {
    str = '  ',
    hl = {
      fg = 'NONE',
      bg = colors.bg_statusline,
    },
  },
  icon = {
    str = ' ',
    hl = { style = 'bold' },
  },
}

M.git_diff = {
  added = {
    provider = 'git_diff_added',
    hl = {
      fg = colors.diff.add,
      bg = colors.bg_statusline,
      style = 'bold',
    },
    right_sep = rignt_sep,
  },
  removed = {
    provider = 'git_diff_removed',
    hl = {
      fg = colors.diff.removed,
      bg = colors.bg_statusline,
      style = 'bold',
    },
    right_sep = rignt_sep,
  },
  changed = {
    provider = 'git_diff_changed',
    hl = {
      fg = colors.diff.changed,
      bg = colors.bg_statusline,
      style = 'bold',
    },
    right_sep = rignt_sep,
  },
}

M.navic = {
  provider = function() return require('nvim-navic').get_location() end,
  enabled = function() return require('nvim-navic').is_available() end,
  truncate_hide = true,
  hl = {
    bg = colors.bg_statusline,
    style = 'bold'
  },
  left_sep = {
    str = '  ',
    hl = {
      fg = 'NONE',
      bg = colors.bg_statusline,
    },
  },
}

M.metals_status = {
  provider = function()
    return vim.g['metals_status']
  end,
  hl = {
    fg = 'white',
    bg = colors.bg_statusline,
  },
  enabled = function()
    return vim.g['metals_status'] ~= nil
  end,
  right_sep = rignt_sep,
}

M.diagnostics = {
  errors = {
    provider = 'diagnostic_errors',
    icon = ' ',
    hl = {
      fg = colors.diagnostics.error,
      bg = colors.bg_statusline
    },
    right_sep = rignt_sep,
  },
  warnings = {
    provider = 'diagnostic_warnings',
    icon = ' ',
    hl = {
      fg = colors.diagnostics.warning,
      bg = colors.bg_statusline
    },
    right_sep = rignt_sep,
  },
  hints = {
    provider = 'diagnostic_hints',
    icon = ' ',
    hl = {
      fg = colors.diagnostics.hint,
      bg = colors.bg_statusline
    },
    right_sep = rignt_sep,
  },
  info = {
    provider = 'diagnostic_info',
    icon = 'כֿ ',
    hl = {
      fg = colors.diagnostics.info,
      bg = colors.bg_statusline
    },
    right_sep = rignt_sep,
  },
}

-- active language server name
M.language_server = {
  provider = function()
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
  icon = ' ',
  enabled = function()
    local clients = vim.lsp.get_active_clients()
    return next(clients) ~= nil
  end,
  hl = {
    bg = colors.bg_statusline,
  },
  right_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = colors.bg_statusline,
    },
  },
}

M.file_info = {
  provider = {
    name = 'file_info',
    opts = {
      -- type = 'relative-path',
      type = 'relative'
    },
  },
  short_provider = {
    name = 'file_info',
    opts = {
      type = 'unique',
    },
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = colors.bg_statusline,
    },
  },
  hl = {
    style = 'bold',
    bg = colors.bg_statusline,
  },
}

M.cwd = {
  provider = function()
    local path = vim.fn.split(vim.fn.getcwd(), '/')
    return path[#path]
  end,
  truncate_hide = true,
  icon = ' ',
  hl = {
    style = 'bold',
    fg = 'white',
    bg = colors.bg_statusline,
  },
}

return M
