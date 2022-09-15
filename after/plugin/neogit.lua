if not pcall(require, 'neogit') then
  return
end

require('neogit').setup({
  integrations = {
    diffview = true
  },
  disable_commit_confirmation = true,
  disable_context_highlighting = true,
})

require('caenrique.functions').keymap({'<Leader>g', ':Neogit<Enter>', description = 'Open Neogit tab page'})
