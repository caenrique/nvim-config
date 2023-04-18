local c = require('plugins.heirline.components')

local space = c.utils.space
local align = c.utils.align

vim.o.laststatus = 3

local default = {
  c.vim_mode, space, c.cwd, space, c.git.branch, space, c.macro_rec, align,
  c.lsp.status, space, c.lsp.name, space, c.ruler,
}

return { default, }
