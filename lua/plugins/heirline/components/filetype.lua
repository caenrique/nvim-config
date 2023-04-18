local utils = require('heirline.utils')

return {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = utils.get_highlight('Type').fg, bold = true },
}
