-- Debug keymaps to evaluate lua code of the whole file or visual selection
vim.keymap.set('n', 'g==', '<cmd>source %<CR>', { desc = 'Source current buffer' })
vim.keymap.set('x', 'g==', ":'<,'>source<CR>", { desc = 'Source current selection' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Make global marks accesible in the home row
vim.keymap.set('n', "'a", "'A")
vim.keymap.set('n', 'ma', 'mA')

vim.keymap.set('n', "'s", "'S")
vim.keymap.set('n', 'ms', 'mS')

vim.keymap.set('n', "'d", "'D")
vim.keymap.set('n', 'md', 'mD')

vim.keymap.set('n', "'f", "'F")
vim.keymap.set('n', 'mf', 'mF')

vim.keymap.set({ 'n', 'x' }, '<leader>p', '"*p', { desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"*y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<C-y>', '<cmd>let @*=@"<CR>',
  { desc = 'Copy the contents of the last used register to the system clipboard' })

vim.keymap.set('n', 'dm', require('caenrique.delete-mark').delete_marks,
  { desc = 'Delete all marks in the current buffer' })

vim.keymap.set('n', 'th', '<cmd>tabprev<cr>', { desc = 'Go to the [T]ab to the left' })
vim.keymap.set('n', 'tl', '<cmd>tabnext<cr>', { desc = 'Go to the [T]ab to the right' })
vim.keymap.set('n', 'td', '<cmd>tabclose<cr>', { desc = '[T]ab [D]delete' })

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'qf',
  callback = function(opts)
    local isLocal = vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1

    if isLocal then
      vim.g.caenrique_loclist_open = true
    else
      vim.g.caenrique_quickfix_open = true
    end

    vim.api.nvim_create_autocmd('BufWinLeave', {
      buffer = opts.buf,
      once = true,
      callback = function()
        if isLocal then
          vim.g.caenrique_loclist_open = false
        else
          vim.g.caenrique_quickfix_open = false
        end
        -- vim.notify('Closing the quickfix window')
        return true -- Delete the autocmd. One off command
      end,
    })
  end,
})

vim.keymap.set('n', '<leader>q', function()
  if vim.g.caenrique_quickfix_open == true then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = 'Toggle the quickfix list' })

vim.keymap.set('n', '<leader>l', function()
  if vim.g.caenrique_loclist_open == true then
    vim.cmd.lclose()
  else
    vim.cmd.lopen()
  end
end, { desc = 'Toggle the location list' })

vim.keymap.set('n', '<leader>r', function()
  local word = vim.fn.expand('<cword>')
  return ':%s/' .. word .. '//g<left><left>'
end, { expr = true, desc = 'Replace word under the cursor in the current buffer' })

vim.keymap.set('x', '<leader>r', ':s#<c-r>/##g<left><left>',
  { desc = 'Replace word on the search register in the current selection' })

vim.keymap.set('n', '<leader>R', function()
  local word = vim.fn.expand('<cword>')
  return ':s/' .. word .. '//g<left><left>'
end, { expr = true, desc = 'Replace word under the cursor in the current line' })

vim.keymap.set('n', '<tab>', 'za', { desc = 'Toggle fold' })
vim.keymap.set('n', '<C-I>', '<C-I>', { noremap = true })
vim.keymap.set('n', '<C-M>', '<C-M>', { noremap = true })

vim.keymap.set({ "x" }, "v", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = 'Incremental Selection: select parent' })

vim.keymap.set({ "x" }, "V", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = 'Incremental Selection: select child' })
