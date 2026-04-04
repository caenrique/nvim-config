vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('caenrique_statuscolumn', { clear = true }),
  callback = function(ev)
    if vim.api.nvim_win_get_config(0).zindex -- floating window
        or vim.bo[ev.buf].filetype == 'neo-tree'
        or vim.bo[ev.buf].buftype == 'terminal'
        or vim.bo[ev.buf].buftype == 'no-file' then
      vim.wo.statuscolumn = ''
    else
      vim.wo.statuscolumn = '%s%=%l %C '
    end

    vim.wo.signcolumn = 'auto:1'
    vim.wo.foldcolumn = 'auto'
  end,
})

vim.o.foldcolumn = '1'
vim.opt_global.fillchars:append({
  fold = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = ' ',
  foldinner = ' ',
})
