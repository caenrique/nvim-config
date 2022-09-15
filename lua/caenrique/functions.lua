local M = {}

local function withDefaults(map, opts)
  map.opts = vim.tbl_extend('keep', map.opts or {}, opts or {}, { silent = true, noremap = true })
  return map
end

function M.keymap(keymap_table)
  require('legendary').bind_keymap(withDefaults(keymap_table))
end

function M.keymaps(keymaps_table, global_opts)
  for _, k in ipairs(keymaps_table) do
    withDefaults(k, global_opts)
  end
  require('legendary').bind_keymaps(keymaps_table)
end

function M.closeNeogitStatus()
  for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
    local current_win = vim.api.nvim_tabpage_get_win(tab_id)
    local current_buffer = vim.api.nvim_win_get_buf(current_win)
    local isNeogit = vim.api.nvim_buf_get_option(current_buffer, 'filetype') == 'NeogitStatus'

    print('Closing Neogit!')

    if isNeogit then
      vim.cmd(vim.api.nvim_tabpage_get_number(tab_id) .. 'tabclose!')
    end
  end
end

function M.format_code()
  if vim.lsp.buf.format() == nil then
    vim.cmd([[Format]])
  end
end

-- config should be
-- {
--    open: one of [split, new_tab]
-- }
Scratch_buffer_id = nil

function M.scratch_buffer(config)
  local command = {
    create = nil,
    open = nil,
  }

  if config.open == 'split' then
    command.open = 'split'
    command.close = 'close'
  elseif config.open == 'new_tab' then
    command.open = 'tabnew'
    command.close = 'tabclose'
  end

  if Scratch_buffer_id == nil then
    vim.cmd(command.open)
    Scratch_buffer_id = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(Scratch_buffer_id)
  elseif vim.api.nvim_get_current_buf() == Scratch_buffer_id then
    vim.cmd(command.close)
  else
    local found_in_window = nil
    for _, window in ipairs(vim.api.nvim_list_wins()) do
      if Scratch_buffer_id == vim.api.nvim_win_get_buf(window) then
        found_in_window = window
      end
    end

    if found_in_window ~= nil then
      vim.api.nvim_set_current_win(found_in_window)
    else
      vim.cmd(command.open)
      vim.api.nvim_set_current_buf(Scratch_buffer_id)
    end
  end
end

function M.run_sbt_command(command)
  local Job = require('plenary.job')

  Job
    :new({
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
    })
    :start()

  print("Running 'sbt " .. command .. "'")
end

return M
