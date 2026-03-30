function _G.Winbar()

  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)

  -- TODO: Add file icon
  local icon = ''
  if _G.MiniIcons then
    local i, hl = require('mini.icons').get('file', vim.api.nvim_buf_get_name(bufnr))
    icon = '%#' .. hl .. '#' .. i
  end

  local function filename()
    if vim.bo[bufnr].modified then
      return '%#NeoTreeModified#%t %m'
    elseif vim.bo[bufnr].filetype == 'help' then
      return '%h %#Normal#%t'
    elseif not vim.bo[bufnr].modifiable then
      return '%#Normal#%t %m'
    else
      return '%#Normal#%t'
    end
  end

  local gethighlight = function(diagnostics)
    local min = vim.diagnostic.severity.HINT
    for _, v in ipairs(diagnostics) do
      if v.severity < min then
        min = v.severity
      end
    end

    local highlights = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
    }

    return highlights[min]
  end

  local diagnostics = vim.diagnostic.status(bufnr) ~= ''
      and vim.diagnostic.status(bufnr) .. ' %#' .. gethighlight(vim.diagnostic.get(bufnr)) .. '# '
    or ''

  local function gitsigns()
    local gitstatus = vim.b[bufnr].gitsigns_status_dict or {}
    local add = gitstatus.added and gitstatus.added ~= 0 and '%#@diff.plus#+' .. gitstatus.added .. ' ' or ''
    local changed = gitstatus.changed and gitstatus.changed ~= 0 and '%#@diff.delta#~' .. gitstatus.changed .. ' ' or ''
    local deleted = gitstatus.removed and gitstatus.removed ~= 0 and '%#@diff.minus#-' .. gitstatus.removed .. ' ' or ''
    return add .. changed .. deleted
  end

  -- TODO: Exclude filetype/buftype
  return ' ' .. icon .. ' ' .. filename() .. ' ' .. gitsigns() .. '%=' .. diagnostics
end

vim.api.nvim_create_autocmd({ 'TermOpen', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('caenrique_winbar', { clear = true }),
  callback = function(ev)
    if vim.api.nvim_win_get_config(0).zindex then
      return
    end
    if vim.bo[ev.buf].filetype ~= 'neo-tree' and vim.bo[ev.buf].buftype ~= 'terminal' then
      vim.wo.winbar = '%!v:lua.Winbar()'
    else
      vim.wo.winbar = ''
    end
  end,
})
