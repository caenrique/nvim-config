-- Debug keymaps to evaluate lua code of the whole file or visual selection
vim.keymap.set('n', 'g==', '<cmd>source %<CR>')
vim.keymap.set('x', 'g==', ":'<,'>source<CR>")

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

vim.keymap.set({ 'n', 'x' }, '<leader>p', '"*p')
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"*y')
vim.keymap.set('n', '<C-y>', '<cmd>let @*=@"<CR>')

vim.keymap.set('n', 'dm', require('caenrique.delete-mark').delete_marks)

vim.keymap.set('n', 'th', '<cmd>tabprev<cr>', { desc = 'Go to the [T]ab to the left' })
vim.keymap.set('n', 'tl', '<cmd>tabnext<cr>', { desc = 'Go to the [T]ab to the right' })
vim.keymap.set('n', 'td', '<cmd>tabclose<cr>', { desc = '[T]ab [D]delete' })

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'qf',
  callback = function(opts)
    -- if getwininfo(win_getid())[0]['loclist'] == 1
    local isLocal = vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1

    if isLocal then
      vim.g.caenrique_loclist_open = true
    else
      vim.g.caenrique_quickfix_open = true
    end
    -- vim.notify('Opening the quickfix window')

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
end, { desc = 'Toggle the quickfix list' })

vim.keymap.set('n', '<leader>r', function()
  local word = vim.fn.expand('<cword>')
  return ':%s/' .. word .. '//g<left><left>'
end, { expr = true })

vim.keymap.set('x', '<leader>r', ':s#<c-r>/##g<left><left>')

vim.keymap.set('n', '<leader>R', function()
  local word = vim.fn.expand('<cword>')
  return ':s/' .. word .. '//g<left><left>'
end, { expr = true })
