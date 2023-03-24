local M = {}

function M.run_sbt_command(command)
  local Job = require('plenary.job')

  Job:new({
    command = 'sbt',
    args = { command },
    cwd = vim.fn.getcwd(),
    on_exit = function(j, return_val)
      if return_val == 0 then
        print("Finished Execution of 'sbt " .. command .. "' successfully!")
      else
        print("Error execution 'sbt " .. command .. "'")
        print(vim.inspect(j:result()))
      end
    end,
  }):start()

  print("Running 'sbt " .. command .. "'")
end

return M
