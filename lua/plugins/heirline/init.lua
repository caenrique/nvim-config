return {
  'rebelot/heirline.nvim',
  enabled = true,
  config = function()
    require('plugins.heirline.disable').disable_statuscolumn({
      buftype = { 'nofile', 'terminal' },
      filetype = 'NeogitStatus'
    })

    require('heirline').setup({
      statusline = require('plugins.heirline.statusline'),
      winbar = require('plugins.heirline.winbar'),
      statuscolumn = require('plugins.heirline.statuscolumn'),
      opts = {
        colors = require('plugins.heirline.components.colors'),
        disable_winbar_cb = function(args)
          local buf = args.buf
          if vim.api.nvim_buf_is_valid(buf) then
            local buftype = vim.tbl_contains({ 'prompt', 'nofile', 'quickfix' }, vim.bo[buf].buftype)
            local filetype = vim.tbl_contains({ 'gitcommit', 'fugitive', 'Trouble', 'packer' }, vim.bo[buf].filetype)
            return buftype or filetype
          else
            return true
          end
        end,
      }
    })
  end
}
