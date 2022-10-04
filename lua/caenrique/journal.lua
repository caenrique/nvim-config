-- [x] Open/Create file for yesterday/today/tomorrow
-- [x] Open/Create file for a specific date
-- Go to next/previous already created file
-- Create simple note
-- Create a note with the selection as content. Prompt for file name, and replace with link
-- [x] Telescope integration for journal and notes
-- Scratch notes buffer
--
local M = {}

local config = {
  journal_base_dir = "~/Notes/Journal",
  extension = '.md',
  date_pattern = '%Y-%m-%d',
}

local function insert_metadata(buffer, title, tags)
  local delim = '---'
  local created_at = os.date('%Y-%m-%d %X', os.time())
  local lines = {
    delim,
    'title: ' .. title,
    'created_at: ' .. created_at,
    'tags: ' .. (tags or ''),
    delim
  }
  vim.api.nvim_buf_set_lines(buffer, 0, 0, true, lines)
end

-- local group = vim.api.nvim_create_augroup("journal", { clear = true })
function M.setup(conf)
  config = vim.tbl_deep_extend('force', config, conf or {})
end

local function parse_date(date_str)
  local year, month, day = date_str:match('(%d+)-(%d+)-(%d+)')
  local date = {
    year = year,
    month = month,
    day = day,
  }
  date.day_of_the_week = os.date('%A', os.time(date))
  return date
end

local function skip_weekend(today, dx)
  local time = today + dx
  local day = os.date('%A', time)
  while day == 'Saturday' or day == 'Sunday' do
    time = time + dx
    day = os.date('%A', time)
  end
  return time
end

function M.open_journal_for_date(date_string)
  local date = parse_date(date_string)
  local path = config.journal_base_dir .. '/' .. date.year .. '/' .. date.month
  local filename = date.day .. '-' .. date.day_of_the_week .. config.extension

  if next(vim.fs.find(filename, { path = vim.fs.normalize(path), type = 'file' })) ~= nil then
    vim.cmd('edit ' .. path .. '/' .. filename)
  elseif vim.fn.buflisted(vim.fs.normalize(path .. '/' .. filename)) > 0 then
    vim.cmd('edit ' .. path .. '/' .. filename)
  else
    vim.fn.mkdir(path, 'p')
    vim.cmd('edit ' .. path .. '/' .. filename)
    local buffer = vim.api.nvim_win_get_buf(0)
    local title = 'Journal of ' .. os.date('%A %d of %B %Y', os.time(date))
    insert_metadata(buffer, title, '#journal')
  end
end

function M.open_journal_today()
  local today = os.date(config.date_pattern)
  M.open_journal_for_date(today)
end

function M.open_journal_yesterday()
  local yesterday = os.date(config.date_pattern, skip_weekend(os.time(), -24 * 60 * 60))
  M.open_journal_for_date(yesterday)
end

function M.open_journal_tomorrow()
  local tomorrow = os.date(config.date_pattern, skip_weekend(os.time(), 24 * 60 * 60))
  M.open_journal_for_date(tomorrow)
end

vim.keymap.set('n', '<leader>fn', function()
  require('telescope.builtin').find_files({ cwd = config.journal_base_dir })
end)
vim.keymap.set('n', '<leader>jj', M.open_journal_today)
vim.keymap.set('n', '<leader>jh', M.open_journal_yesterday)
vim.keymap.set('n', '<leader>jl', M.open_journal_tomorrow)

return M
