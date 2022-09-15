require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.journal"] = {
      config = {
        workspace = 'work'
      }
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          work = "~/Notes/work",
          home = "~/Notes/home",
        }
      }
    },
    ["core.norg.completion"] = {
      config = {
        engine = 'nvim-cmp'
      }
    },
    ["core.integrations.nvim-cmp"] = {
      config = {}
    }
  }
}

local keymaps = require('caenrique.functions').keymaps

keymaps({
  { '<leader>jj', ':Neorg journal today<CR>', description = 'Open a file in the journal for today' },
  { '<leader>jh', ':Neorg journal yesterday<CR>', description = 'Open a file in the journal for yesterday' },
  { '<leader>jl', ':Neorg journal tomorrow<CR>', description = 'Open a file in the journal for tomorrow' },
})
