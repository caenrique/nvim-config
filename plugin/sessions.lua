local group = vim.api.nvim_create_augroup('caenrique.sessions', { clear = true })
local sessions_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'sessions')


-- folds: manually created folds, opened/closed folds and local fold options
-- help: the help window
-- skiprtp: exclude 'runtimepath' and 'packpath' from the options
-- terminal: include terminal windows where the command can be restored
-- winsize: window sizes
vim.o.sessionoptions = 'help,winsize,folds,skiprtp'

local function session_path()
  local path = vim.fs.abspath(vim.fn.getcwd())
  local session_name = string.gsub(string.gsub(string.sub(path, 2), '%.', '_'), '/', '.')
  local session_file = string.format('%s.vim', session_name)
  return vim.fs.joinpath(sessions_dir, session_file)
end

-- Checks if a session file for this directory exists
local function should_save_session()
  return vim.uv.fs_stat(session_path())
end

local function close_windows()
  -- It does nothing at the moment
  -- Neo-tree seems to close by itself now.
end

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = group,
  callback = function()
    -- Check if sessions enabled
    if not should_save_session() then return end

    -- Close windows that don't work well with sessions
    close_windows()

    -- Create session
    vim.cmd.mksession({ session_path(), bang = true })
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  callback = function()
    if vim.uv.fs_stat(session_path()) then
      vim.schedule(function() vim.cmd.source(session_path()) end)
    end
  end,
})

vim.api.nvim_create_user_command('SaveSession', function()
  vim.cmd.mksession({ session_path(), bang = true })
end, { desc = 'Save Session' })

vim.api.nvim_create_user_command('DeleteSession', function()
  if not vim.uv.fs_stat(session_path()) then return end
  vim.fs.rm(session_path())
end, { desc = 'Save Session' })
