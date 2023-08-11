local function general_next()
  local mark_line, _ = unpack(vim.api.nvim_buf_get_mark(0, 'f'))
  local cursor_line, _ = unpack(vim.api.nvim_win_get_cursor(0))

  if mark_line == cursor_line then
    vim.api.nvim_feedkeys(';', 'n', true)
  elseif mark_line > 0 then
    vim.api.nvim_buf_del_mark(0, 'f')
    vim.api.nvim_feedkeys('nzz', 'n', true)
  else
    vim.api.nvim_feedkeys('nzz', 'n', true)
  end
end

local function general_previous()
  local mark_line, _ = unpack(vim.api.nvim_buf_get_mark(0, 'f'))
  local cursor_line, _ = unpack(vim.api.nvim_win_get_cursor(0))

  if mark_line == cursor_line then
    vim.api.nvim_feedkeys(',', 'n', true)
  elseif mark_line > 0 then
    vim.api.nvim_buf_del_mark(0, 'f')
    vim.api.nvim_feedkeys('Nzz', 'n', true)
  else
    vim.api.nvim_feedkeys('Nzz', 'n', true)
  end
end

vim.keymap.set('n', 'f', 'mff')
vim.keymap.set('n', 'n', general_next)
vim.keymap.set('n', 'N', general_previous)


vim.keymap.set('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })

vim.keymap.set('n', '<leader><esc>', ':nohlsearch<CR>')
vim.keymap.set('n', 'th', ':tabprev<CR>')
vim.keymap.set('n', 'tl', ':tabnext<CR>')
vim.keymap.set('n', 'td', ':tabclose<CR>')
vim.keymap.set('n', 'gh', '<C-W>h')
vim.keymap.set('n', 'gl', '<C-W>l')
vim.keymap.set('n', 'gk', '<C-W>k')
vim.keymap.set('n', 'gj', '<C-W>j')
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>')
vim.keymap.set('n', '<C-6>', '<C-^>')

vim.keymap.set({ 'n', 'v' }, 'j', "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count ? 'k' : 'gk'", { expr = true })

vim.keymap.set('v', '[', '"ss[<C-R>s]<esc>')
vim.keymap.set('v', '{', '"ss{<C-R>s}<esc>')
vim.keymap.set('v', '(', '"ss(<C-R>s)<esc>')
vim.keymap.set('v', '<leader>"', '"ss"<C-R>s"<esc>')
vim.keymap.set('v', "'", '"ss\\"<C-R>s\\"<esc>')
vim.keymap.set('v', '`', '"ss`<C-R>s`<esc>')

vim.keymap.set('n', '<Tab>', 'za')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
-- TODO: Find a proper mapping for next/previous occurence for a find command (find in line with f). It's slow because I use `;` for other mappings
--
vim.keymap.set('n', '<C-q>', 'q')
vim.keymap.set('n', 'q', '<cmd>copen<cr>')

vim.keymap.set('i', '<C-BS>', "col('.') == 1 ? '<C-W><C-F>' : '<C-W>'", { expr = true })
