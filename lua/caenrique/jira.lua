local M = {}
local Curl = require('plenary.curl')

local config = {
  jira_domain = vim.g.jira_domain or vim.env.JIRA_DOMAIN,
  jira_api_token = vim.g.jira_api_token or vim.env.JIRA_API_TOKEN,
  jira_user = vim.g.jira_user or vim.env.JIRA_USER,
}

local jira_base_url = string.format('https://%s/rest/api/2', config.jira_domain)

local function parse_ticket(body)
  local r = vim.json.decode(body)
  return {
    title = r.fields.summary,
    description = r.fields.description,
    id = r.key,
    assignee = r.fields.assignee.displayName,
    status = r.fields.status.name,
  }
end

function M.test_request(id)
  local result = Curl.get {
    url = jira_base_url .. '/issue/' .. id,
    raw = { '-H', 'Authorization: Bearer ' .. config.jira_api_token },
  }

  local ticket = parse_ticket(result.body)
  vim.print(vim.inspect(ticket))
end

return M
