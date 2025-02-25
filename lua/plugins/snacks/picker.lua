return {
  sources = {
    grep = {
      finder = 'grep',
      regex = true,
      format = 'file',
      show_empty = true,
      live = true, -- live grep by default
      supports_live = true,
      formatters = {
        file = {
          filename_first = false,
          truncate = 40,
        },
      },
      layout = {
        hidden = {},
      },
    },
  },
  formatters = {
    file = {
      filename_first = true,
      truncate = 60,
    },
  },
  layout = {
    cycle = true,
    hidden = { 'preview' },
    --- Use the default layout or vertical if the window is too narrow
    preset = function()
      return vim.o.columns >= 160 and 'default' or 'vertical'
    end,
  },
  layouts = {
    vertical = {
      layout = {
        backdrop = false,
        width = 0.8,
        min_width = 80,
        height = 0.9,
        min_height = 30,
        box = 'vertical',
        border = 'rounded',
        title = '{title} {live} {flags}',
        title_pos = 'center',
        { win = 'preview', title = '{preview}', height = 0.5, border = 'bottom' },
        { win = 'input', height = 1, border = 'none' },
        { win = 'list', border = 'top' },
      },
    },
  },
}
