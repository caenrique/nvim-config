local Job = require 'plenary.job'

local M = {}

function M.open()

  if not M.instance then
    M.instance = {}
    M.instance.buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(M.instance.buffer, true, {
      split = 'below',
      win = -1
    })
    M.instance.terminal = vim.api.nvim_open_term(M.instance.buffer, {})

    print('terminal id: ' .. vim.inspect(M.instance.terminal))
  else
    vim.api.nvim_open_win(M.instance.buffer, true, {
      split = 'below',
      win = -1
    })
  end


  -- vim.api.nvim_chan_send(M.instance.terminal, "sbtn " .. command)
end

function M.send_command(command)
  local result = vim.system({ 'sbtn', command }):wait()
  print(result.stdout)
end

function M.openSbtTerminal()
  if M.instance.buffer ~= nil then
    vim.api.nvim_open_win(M.instance.buffer, true, {
      split = 'below',
      win = -1
    })
  end
end

return M
