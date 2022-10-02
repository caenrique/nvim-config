-- [x] Open/Create file for yesterday/today/tomorrow
-- [x] Open/Create file for a specific date
-- Go to next/previous already created file
-- Create simple note
-- Create a note with the selection as content. Prompt for file name, and replace with link
-- [x] Telescope integration for journal and notes
-- Scratch notes buffer

local M = {}

local config = {
  journal_base_dir = "~/Notes/Journal",
  extension = '.md',
  date_pattern = '%Y-%m-%d',
}

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

local function make_filename(date)
  return date.year .. '/' .. date.month .. '/' .. date.day .. '-' .. date.day_of_the_week .. config.extension
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
  local filename = config.journal_base_dir .. '/' .. make_filename(date)

  vim.fn.mkdir(vim.fn.expand(filename .. ':p:h'), 'p')
  vim.cmd.edit(filename)
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

vim.keymap.set('n', '<leader>fn', function() require('telescope.builtin').find_files({ cwd = config.journal_base_dir }) end)
vim.keymap.set('n', '<leader>jj', M.open_journal_today)
vim.keymap.set('n', '<leader>jh', M.open_journal_yesterday)
vim.keymap.set('n', '<leader>jl', M.open_journal_tomorrow)

return M
