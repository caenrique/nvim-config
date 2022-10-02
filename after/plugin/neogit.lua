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

vim.keymap.set('n', '<Leader>g', ':Neogit<Enter>')
