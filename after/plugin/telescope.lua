if not pcall(require, 'telescope') then
  return
end

local actions = require('telescope.actions')

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>mc', require('telescope').extensions.metals.commands)
vim.keymap.set('n', '<leader>C', function() require('telescope.builtin').find_files({prompt_title = 'neovim config', cwd = '~/.config/nvim/'}) end)

require('telescope').setup({
  defaults = {
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    color_devicons = true,
    layout_config = { prompt_position = 'top' },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        --["<esc>"] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = 'dropdown',
      previewer = false,
      mappings = {
        i = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
      },
    },
  },
})

require('telescope').load_extension('fzf')
