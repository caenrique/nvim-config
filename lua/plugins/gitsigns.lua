return {
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function keymap(modes, lh, rh, opts)
        vim.keymap.set(modes, lh, rh, vim.tbl_deep_extend('force', { silent = true, buffer = bufnr }, opts or {}))
      end

      -- Navigation
      keymap('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      keymap('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true })

      -- Actions
      keymap({ 'n', 'v' }, '<leader>lsh', ':Gitsigns stage_hunk<CR>')
      keymap({ 'n', 'v' }, '<leader>lrh', ':Gitsigns reset_hunk<CR>')
      keymap('n', '<leader>lsb', gs.stage_buffer)
      keymap('n', '<leader>lu', gs.undo_stage_hunk)
      keymap('n', '<leader>lR', gs.reset_buffer)
      keymap('n', '<leader>lk', gs.preview_hunk_inline)
      keymap('n', '<leader>lb', gs.toggle_current_line_blame)
      keymap('n', '<leader>ld', gs.diffthis)
      keymap('n', '<leader>lD', function() gs.diffthis('~') end)

      -- Text object
      keymap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
}
