local conditions = require("heirline.conditions")
local colors = require("plugins.heirline.components.colors")

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  -- You can keep it simple,
  -- provider = " [LSP]",
  -- Or complicate things a bit and get the servers names
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return " " .. table.concat(names, " ")
  end,
  hl = { fg = colors.green, bold = true },
}

-- See lsp-status/README.md for configuration options.
local LSPMessages = {
  provider = function()
    return vim.g["metals_status"]
  end,
  hl = { fg = colors.gray },
  condition = function()
    return vim.g["metals_status"] ~= nil
  end,
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  {
    condition = function(self)
      return self.errors > 0
    end,
    provider = function(self)
      return " " .. self.error_icon .. self.errors .. " "
    end,
    hl = { fg = colors.bg, bg = colors.diag_error, bold = true },
  },
  {
    condition = function(self)
      return self.warnings > 0
    end,
    provider = function(self)
      return " " .. self.warn_icon .. self.warnings .. " "
    end,
    hl = { fg = colors.bg, bg = colors.orange, bold = true },
  },
  {
    condition = function(self)
      return self.info > 0
    end,
    provider = function(self)
      return " " .. self.info_icon .. self.info .. " "
    end,
    hl = { fg = colors.bg, bg = colors.diag_info, bold = true },
  },
  {
    condition = function(self)
      return self.hints > 0
    end,
    provider = function(self)
      return " " .. self.hint_icon .. self.hints .. " "
    end,
    hl = { fg = colors.bg, bg = colors.diag_hint, bold = true },
  },
}

return {
  name = LSPActive,
  status = LSPMessages,
  diagnostics = Diagnostics,
}
