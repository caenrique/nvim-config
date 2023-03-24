return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        color_devicons = true,
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        mappings = {
          i = {
              ['<esc>'] = actions.close,
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
  end,
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end },
    { '<leader>fb', function() require('telescope.builtin').buffers() end },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end },
    { '<leader>mc', function() require('telescope').extensions.metals.commands() end },
  }
}
