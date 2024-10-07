local utils = require('heirline.utils')

local hi = {
  bright_bg = utils.get_highlight('Folded').bg,
  bright_fg = utils.get_highlight('Folded').fg,
  bg = utils.get_highlight('Normal').bg,
  fg = utils.get_highlight('Normal').fg,
  red = utils.get_highlight('DiagnosticError').fg,
  dark_red = utils.get_highlight('DiffDelete').bg,
  green = utils.get_highlight('String').fg,
  blue = utils.get_highlight('Function').fg,
  gray = utils.get_highlight('NonText').fg,
  orange = utils.get_highlight('Constant').fg,
  purple = utils.get_highlight('Statement').fg,
  cyan = utils.get_highlight('Special').fg,
  diag_warn = utils.get_highlight('DiagnosticWarn').guifg,
  diag_error = utils.get_highlight('DiagnosticError').fg,
  diag_hint = utils.get_highlight('DiagnosticHint').fg,
  diag_info = utils.get_highlight('DiagnosticInfo').fg,
  git_del = utils.get_highlight('DiffDelete').fg,
  git_add = utils.get_highlight('DiffAdd').fg,
  git_change = utils.get_highlight('DiffChange').fg,
}

-- vim.print(hi)

return hi
