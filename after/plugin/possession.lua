if not pcall(require, 'possession') then
  return
end

vim.o.sessionoptions = 'curdir,tabpages,winsize,folds'

require('telescope').load_extension('possession')

require('possession').setup {
  hooks = {
    after_load = function(name, _)
      if string.find(name, "scala") then
        vim.cmd('<CMD>MetalsRestartServer<CR>')
      end
    end,
  },
  commands = {
    save = 'SessionSave',
    load = 'SessionLoad',
    close = 'SessionClose',
    delete = 'SessionDelete',
    show = 'SessionShow',
    list = 'SessionList',
    migrate = 'SessionMigrate',
  },
  plugins = {
    close_windows = {
      match = {
        filetype = { 'neo-tree' },
        buftype = { 'terminal' },
      },
    },
  },
}

vim.keymap.set('n', '<C-P>', require('telescope').extensions.possession.list, { silent = true })