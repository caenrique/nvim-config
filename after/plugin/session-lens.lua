if not pcall(require, 'session-lens') then
  return
end

require('session-lens').setup()
require('caenrique.functions').keymap({'<leader>p', '<cmd>SearchSession<CR>'})
