local conditions = require('heirline.conditions')

return {
  provider = function()
    -- local icon = (vim.fn.haslocaldir(0) == 1 and 'l' or 'g') .. ' ' .. ' '
    local icon = ' '
    local cwd = vim.fn.getcwd(0)
    cwd = vim.fn.fnamemodify(cwd, ':~')

    local _, _, sirius_dir = cwd:find("~/Projects/ghe.siriusxm.com/([^/]+)")
    local _, _, github_org, github_dir = cwd:find("~/Projects/github.com/([^/]+)/([^/]+)")

    if sirius_dir then
      cwd = sirius_dir
    elseif github_org and github_dir then
      cwd = github_org .. '/' .. github_dir
    end

    if not conditions.width_percent_below(#cwd, 0.25) then
      cwd = vim.fn.pathshorten(cwd)
    end
    local trail = cwd:sub(-1) == '/' and '' or '/'
    return icon .. cwd .. trail
  end,
  hl = { fg = 'blue', bold = true },
}
