local M = {}

local Parser = {
  states = {
    searching_suite_name = 'searching_suite_name',
    searching_test_name = 'searching_test_name',
    gathering_test_output = 'gathering_test_output',
    finished = 'finished',
  },
}

local TestRunner = {
  namespace = vim.api.nvim_create_namespace('scala-cli weaver tests'),
}

-- TODO: Add type anotations

-- Utility function to get a slice of a list
function table.slice(tbl, first, last)
  local sliced = {}

  for i = first or 1, last or #tbl do
    sliced[#sliced + 1] = tbl[i]
  end

  return sliced
end

function Parser.isTestSuite(line)
  return line:match('^%u')
end

function Parser.isTestName(line)
  return line:match('^- %w')
end

function Parser.strip_empty_lines(lines)
  local lastNonEmptyLine = 1
  for index, line in ipairs(lines) do
    if line and line ~= '' then
      lastNonEmptyLine = index
    end
  end
  return table.slice(lines, 1, lastNonEmptyLine)
end

function Parser.parse_lines(lines)
  local state = {
    lines_remaining = Parser.strip_empty_lines(lines),
    state = nil,
    current_suite = nil,
    current_test_name = nil,
    output = {},
  }

  local function next_line()
    if state.lines_remaining then
      return state.lines_remaining[1]
    else
      return nil
    end
  end

  local function dropLine()
    table.remove(state.lines_remaining, 1)
  end

  local function isFinished()
    return #state.lines_remaining == 0 or state.state == Parser.states.finished
  end

  while not isFinished() do
    local current_line = next_line()
    if current_line == nil then
      state.state = Parser.states.finished
    else
      if state.state == nil then
        if current_line:match('*************FAILURES**************') then
          state.state = Parser.states.searching_suite_name
        end
        dropLine()
      elseif state.state == Parser.states.searching_suite_name then
        if Parser.isTestSuite(current_line) then
          state.current_suite = current_line
          state.state = Parser.states.searching_test_name
        end
        dropLine()
      elseif state.state == Parser.states.searching_test_name then
        if Parser.isTestName(current_line) then
          state.current_test_name = current_line
          state.output[current_line] = {}
          state.state = Parser.states.gathering_test_output
          dropLine()
        elseif Parser.isTestSuite(current_line) then
          state.state = Parser.states.searching_suite_name
        else
          dropLine()
        end
      elseif state.state == Parser.states.gathering_test_output then
        if Parser.isTestSuite(current_line) then
          state.state = Parser.states.searching_suite_name
        elseif Parser.isTestName(current_line) then
          state.state = Parser.states.searching_test_name
        elseif current_line ~= '' then
          table.insert(state.output[state.current_test_name], current_line)
          dropLine()
        else
          dropLine()
        end
      elseif state.state == Parser.states.finished then
        return state
      else
        vim.notify('Something went wrong')
        return nil
      end
    end
  end

  return state
end

function TestRunner.parse_output(terminal_bufnr)
  -- Get all lines of the output buffer
  -- from 0 to the last one (-1)
  local lines = vim.api.nvim_buf_get_lines(terminal_bufnr, 0, -1, true)

  -- Parse those lines and get a structured result back
  local result = Parser.parse_lines(lines)

  -- Get only the failed tests
  local failed = result and result.output or {}

  -- TODO: Get also the successful tests and add an ✅ emoji to show that it passed

  -- Indexing helpers
  local diagnostics_by_bufnr = {}
  local bufnr_by_filename = {}

  local buffers = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buffers) do
    vim.diagnostic.reset(TestRunner.namespace, bufnr)
  end

  for test, output in pairs(failed) do
    local message = table.concat(table.slice(output, 2, #output), '\n')

    local filepath, line = output[1]:match('%(%.%./%.%./(.+%.scala):(%d+)%)')

    local failedTest = {
      name = test,
      filepath = vim.fs.normalize(vim.fs.abspath(filepath)),
      line = tonumber(line),
      message = message,
    }

    local function find_buffer()
      for _, buffer in ipairs(buffers) do
        local buffer_name = vim.api.nvim_buf_get_name(buffer)
        if vim.fs.normalize(buffer_name) == failedTest.filepath then
          bufnr_by_filename[failedTest.filepath] = buffer
          return buffer
        end
      end
      return nil
    end

    local bufnr = bufnr_by_filename[filepath] or find_buffer()

    if not bufnr then
      bufnr = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_buf_set_name(bufnr, failedTest.filepath)
    end

    vim.api.nvim_buf_call(bufnr, vim.cmd.edit)

    diagnostics_by_bufnr[bufnr] = diagnostics_by_bufnr[bufnr] or {}

    -- TODO: Add an extra diagnostic to the line where the tests begins

    table.insert(diagnostics_by_bufnr[bufnr], {
      bufnr = bufnr,
      lnum = failedTest.line,
      col = 0, -- TODO: Get the column number by parsing the buffer
      severity = vim.diagnostic.severity.ERROR,
      message = failedTest.message,
      source = 'scala-cli',
      namespace = TestRunner.namespace,
    })
  end

  for bufnr, diagnostics in pairs(diagnostics_by_bufnr) do
    vim.diagnostic.set(TestRunner.namespace, bufnr, diagnostics)
  end
end

function TestRunner.open_location_list()
  vim.cmd.q()
  vim.diagnostic.setloclist()
end

function TestRunner.open_quickfix_list()
  vim.cmd.q()
  vim.diagnostic.setqflist()
end

function TestRunner.setup_keymaps(buffer, single)
  vim.keymap.set({ 't', 'n' }, 'q', '<cmd>q<cr>', { buffer = buffer })

  if single then
    vim.keymap.set({ 't', 'n' }, '<C-q>', TestRunner.open_location_list, { buffer = buffer })
  else
    vim.keymap.set({ 't', 'n' }, '<C-q>', TestRunner.open_quickfix_list, { buffer = buffer })
  end
end

function TestRunner.run_test(path)
  -- Create an empty buffer and setup some keymaps in that buffer
  local buffer = vim.api.nvim_create_buf(false, true)
  TestRunner.setup_keymaps(buffer, true)

  -- Open a floating window to display our buffer
  TestRunner.create_window(path, buffer)

  -- Create a terminal instance in the buffer we just created.
  -- This makes neovim handle what is displayed as terminal input sequences
  -- This won't spawn any process by default (e.g. bash)
  local channel = vim.api.nvim_open_term(buffer, {})

  -- Call scala-cli and send stdout to the terminal we just created
  -- we have just embedded a terminal in neovim displaying the output of scala-cli
  vim.system({ 'scala-cli', 'test', path }, {
    text = true,
    cwd = vim.fn.getcwd(),
    stdout = function(_, data)
      if data ~= nil then
        vim.schedule(function()
          vim.api.nvim_chan_send(channel, data)
        end)
      end
    end,
  }, function(out)
    if out.code == 0 then
      vim.notify('Finished job: test passed!')
    else
      vim.notify('Finished job: test failed!')
    end

    vim.schedule(function()
      TestRunner.parse_output(buffer)
    end)
  end)
end

function TestRunner.create_window(filename, buffer)
  vim.api.nvim_open_win(buffer, true, {
    relative = 'editor',
    row = math.floor((vim.o.lines / 2) - (vim.o.lines / 3)),
    col = math.floor((vim.o.columns / 2) - (vim.o.columns / 3)),
    width = math.floor(vim.o.columns * 2 / 3),
    height = math.floor(vim.o.lines * 2 / 3),
    style = 'minimal',
    border = 'single',
    title = 'scala-cli test ' .. filename,
  })
end

function M.run_test_file()
  local file = vim.fs.relpath(vim.fn.getcwd(), vim.fn.getreg('%'))
  TestRunner.run_test(file)
end

function M.run_tests_workspace()
  TestRunner.run_test('.')
end

function M.setup()
  vim.api.nvim_create_user_command('RunTestFile', M.run_test_file, {})
  vim.api.nvim_create_user_command('RunTestsWorkspace', M.run_tests_workspace, {})
end

return M
