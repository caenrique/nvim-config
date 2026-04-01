local M = {}
function M.list_pull_requests()
  local cmd = {
    'gh',
    'pr',
    'list',
    '--json',
    'number,author,title,updatedAt,isDraft,labels,body',
  }

  vim.system(cmd, function(out)
    -- vim.print(vim.inspect(out))
    local response = {}
    if out.stdout ~= nil and out.stdout ~= '' then
      response = vim.json.decode(out.stdout)
    end

    vim.print(vim.inspect(response))

    local pr_format = '%s #%s %s @%s [%s]' -- status, number, title, author, labels

    for _, pr in ipairs(response) do

      local label_string = ''
      for i, label in ipairs(pr.labels) do
        label_string = label_string .. (i > 1 and ',' or '') .. label.name
      end

      vim.print(
        string.format(pr_format, pr.isDraft and '' or '', pr.number, pr.title, pr.author.login, label_string)
      )
    end
  end)
end

return M
