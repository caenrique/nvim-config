local colors = require("plugins.heirline.components.colors")

return {
  condition = function()
    return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
  end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then
      self.search = search
    end
  end,
  hl = { fg = colors.bg, bg = colors.fg },
  provider = function(self)
    local search = self.search
    return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
  end,
}
