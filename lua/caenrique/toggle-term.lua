local M = {}
local lastTerm = nil

function M.toggle_last()
  if lastTerm ~= nil then
    vim.call('nvim_toggle_terminal#Toggle', lastTerm)
  end
end

function M.toggle(term)
  vim.call('nvim_toggle_terminal#Toggle', term)
  lastTerm = term
end

return M
