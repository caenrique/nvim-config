local uv = vim.loop

local read_file = function(path, callback)
  uv.fs_open(path, 'r', 438, function(err, fd)
    assert(not err, err)
    uv.fs_fstat(fd, function(err, stat)
      assert(not err, err)
      uv.fs_read(fd, stat.size, 0, function(err, data)
        assert(not err, err)
        uv.fs_close(fd, function(err)
          assert(not err, err)
          callback(data)
        end)
      end)
    end)
  end)
end

local function find_test_results_files()
  return vim.fs.find('test-results-latest.json', {
    path = vim.fn.getcwd(),
    limit = math.huge,
  })
end

local function path_from_qualified_name(name, path)

  local package_segments = {}
  for segment in string.gmatch(name, '[^.]+') do
    table.insert(package_segments, segment)
  end

  local filename = table.remove(package_segments) .. '.scala'
  local package_path = vim.fs.joinpath(path, 'test', 'scala', unpack(package_segments))


  local file = vim.fs.find(filename, {
    path = package_path,
  })

  return file[1]
end

local function get_line_of_test(path, test_name)
  local match = {}
  for i, line in ipairs(vim.fn.readfile(path)) do
    local col = string.find(line, test_name)
    if col then
      match = { line = i, column = col }
      break
    end
  end
  return match
end

local function test_results()
  local files = find_test_results_files()
  vim.fn.setqflist({}, 'r')

  for _, file in ipairs(files) do

    local src_dir
    for dir in vim.fs.parents(file) do
      local joined_path = vim.fs.joinpath(dir, 'src')
      if vim.fn.isdirectory(joined_path) == 1 then
        src_dir = joined_path
        break
      end
    end

    read_file(file, vim.schedule_wrap(function(data)

      local results = {}

      for s in data:gmatch('[^\r\n]+') do
        local json = vim.json.decode(s)

        if json.status ~= 'SUCCESS' then
          local path = path_from_qualified_name(json.suite, src_dir)
          local pos = get_line_of_test(path, json.test)
          local text = json.status .. ' | ' .. json.test

          if json.errorMessage ~= "" then
            text = text .. ' | message: ' .. json.errorMessage
          end

          table.insert(results, {
            filename = path,
            lnum = pos.line,
            col = pos.column,
            text = text,
          })
        end
      end

      if next(results) then
        vim.fn.setqflist(results, 'a')
      end

    end
    ))
  end

  vim.cmd.copen()
end

vim.api.nvim_create_user_command('TestResults', test_results, {})
