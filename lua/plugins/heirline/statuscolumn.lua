local align = require('plugins.heirline.components.utils').align

local Icons = {
  collapsed = ' ',
  expanded  = ' ',
}

local function is_virtual_line()
  return vim.v.virtnum < 0
end

local function is_wrapped_line()
  return vim.v.virtnum > 0
end

local function not_in_fold_range()
  return vim.fn.foldlevel(vim.v.lnum) <= 0
end

local function not_fold_start(line)
  line = line or vim.v.lnum
  return vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1)
end

local function fold_opened(line)
  return vim.fn.foldclosed(line or vim.v.lnum) == -1
end

local function fold_icon()
  if is_wrapped_line() or is_virtual_line() then
    return ''
  end

  local icon
  if not_in_fold_range() or not_fold_start() then
    icon = '  '
  elseif fold_opened() then
    icon = Icons.expanded
  else
    icon = Icons.collapsed
  end

  return icon
end

local number = { provider = '%l' }

local fold = {
  -- on_click = function()
  --   local line = vim.fn.getmousepos().line
  --   if not_fold_start(line) then
  --     return
  --   end
  --   vim.cmd.execute("'" .. line .. 'fold' .. (fold_opened(line) and 'close' or 'open') .. "'")
  -- end,
  provider = fold_icon,
  hl = 'FoldColumn'
}

local signs = {
  provider = '%s'
}

local padding = {
  provider = ' ',
}

return {
  signs,
  align,
  number,
  padding,
  fold,
}
