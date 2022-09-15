if not pcall(require, 'auto-session') then
  return
end

-- vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.o.sessionoptions = 'buffers,curdir,tabpages,winsize'

require('auto-session').setup({
  pre_save_cmds = {
    -- 'tabdo NvimTreeClose',
    --"DiffviewClose",
    --"TroubleClose",
    -- require("caenrique.functions").close_neogit_status
  },
})
