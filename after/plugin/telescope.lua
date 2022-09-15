if not pcall(require, 'telescope') then
  return
end

local keymaps = require('caenrique.functions').keymaps
local actions = require('telescope.actions')

keymaps({
  { '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files()<cr>", description = 'Telescope find files' },
  { '<leader>fg', "<cmd>lua require'telescope.builtin'.live_grep()<cr>", description = 'Telescope live grep' },
  { '<leader>fb', "<cmd>lua require'telescope.builtin'.buffers()<cr>", description = 'Telescope find open buffers' },
  { '<leader>fh', "<cmd>lua require'telescope.builtin'.help_tags()<cr>", description = 'Telescope find help docs' },
  {
    '<leader>mc',
    "<cmd>lua require'telescope'.extensions.metals.commands()<cr>",
    description = 'Telescope Metals commands',
  },
  {
    '<leader>C',
    "<cmd>lua require'telescope.builtin'.find_files({prompt_title = 'neovim config', cwd = '~/.config/nvim/'})<CR>",
  },
})

-- keymap('n', '<leader>c', "<cmd>lua require'telescope.builtin'.commands()<cr>")
--keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>")
--
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
