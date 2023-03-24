require('caenrique.options')
require('caenrique.diagnostic')
require('caenrique.keymaps')
require('caenrique.commands')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

vim.api.nvim_create_user_command('Reload',
  function(params)
    for _, plugin_name in ipairs(params.fargs) do
      local plugin = require('lazy.core.config').plugins[plugin_name]
      require('lazy.core.loader').reload(plugin)
    end
  end,
  {
    nargs = '*',
    complete = function()
      return vim.tbl_keys(require('lazy.core.config').plugins)
    end
  }
)
