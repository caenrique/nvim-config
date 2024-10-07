local utils = require("heirline.utils")
local colors = require("plugins.heirline.components.colors")

local FileNameBlock = {
  -- let's first set up some attributes needed by this component and it's children
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}
-- We can now define some children separately and add them later

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon .. " ")
  end,
  hl = function(self)
    return { bg = colors.bg, fg = self.icon_color }
  end,
}

local FileName = {
  init = function(self)
    self.shortfilename = vim.fn.fnamemodify(self.filename, ":t")
    if self.shortfilename == "" then
      self.shortfilename = "[No Name]"
    end
  end,
  hl = { fg = colors.bg, bold = true },

  flexible = 2,

  {
    provider = function(self)
      return " " .. self.shortfilename
    end,
  },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "",
    hl = { fg = "orange" },
  },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

-- let's add the children to our FileNameBlock component
return utils.insert(
  FileNameBlock,
  FileIcon,
  FileName, -- a new table where FileName is a child of FileNameModifier
  FileFlags,
  { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)
