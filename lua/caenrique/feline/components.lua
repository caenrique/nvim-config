local M = {}

local colors = require('caenrique.colors')

local function right_sep(color)
  return {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = color
    },
  }
end

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
      fg = colors.background,
      style = 'bold',
    }
  end,
  right_sep = right_sep(colors.statusline.background),
  icon = '',
}

M.git_branch = {
  provider = 'git_branch',
  hl = {
    fg = colors.text,
    bg = colors.statusline.background,
    style = 'bold',
  },
  left_sep = {
    str = '  ',
    hl = {
      fg = 'NONE',
      bg = colors.statusline.background,
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
      bg = colors.statusline.background,
      style = 'bold',
    },
    right_sep = right_sep(colors.statusline.background),
  },
  removed = {
    provider = 'git_diff_removed',
    hl = {
      fg = colors.diff.removed,
      bg = colors.statusline.background,
      style = 'bold',
    },
    right_sep = right_sep(colors.statusline.background),
  },
  changed = {
    provider = 'git_diff_changed',
    hl = {
      fg = colors.diff.changed,
      bg = colors.statusline.background,
      style = 'bold',
    },
    right_sep = right_sep(colors.statusline.background),
  },
}

M.metals_status = {
  provider = function()
    return vim.g['metals_status']
  end,
  icon = '',
  hl = {
    fg = colors.text,
    bg = colors.statusline.background,
  },
  enabled = function()
    return vim.g['metals_status'] ~= nil
  end,
  right_sep = right_sep(colors.statusline.background),
}

M.diagnostics = {
  errors = {
    provider = 'diagnostic_errors',
    icon = ' ',
    hl = {
      fg = colors.diagnostics.error,
      bg = colors.statusline.background
    },
    right_sep = right_sep(colors.statusline.background),
  },
  warnings = {
    provider = 'diagnostic_warnings',
    icon = ' ',
    hl = {
      fg = colors.diagnostics.warning,
      bg = colors.statusline.background
    },
    right_sep = right_sep(colors.statusline.background),
  },
  hints = {
    provider = 'diagnostic_hints',
    icon = ' ',
    hl = {
      fg = colors.diagnostics.hint,
      bg = colors.statusline.background
    },
    right_sep = right_sep(colors.statusline.background),
  },
  info = {
    provider = 'diagnostic_info',
    icon = 'כֿ ',
    hl = {
      fg = colors.diagnostics.info,
      bg = colors.statusline.background
    },
    right_sep = right_sep(colors.statusline.background),
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
    bg = colors.statusline.background,
    fg = colors.text,
  },
  right_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = colors.statusline.background,
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
      bg = colors.statusline.background,
    },
  },
  hl = {
    style = 'bold',
    fg = colors.text,
    bg = colors.statusline.background,
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
    fg = colors.text,
    bg = colors.statusline.background,
  },
}

return M
