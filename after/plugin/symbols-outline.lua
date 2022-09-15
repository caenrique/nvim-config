if not pcall(require, 'symbols-outline') then
  return
end

require('caenrique.functions').keymap({
  '<leader>so',
  ':SymbolsOutline<CR>',
  description = 'Open the symbols outline window',
})
