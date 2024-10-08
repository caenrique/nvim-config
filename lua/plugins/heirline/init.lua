return {
  "rebelot/heirline.nvim",
  enabled = true,
  config = function()
    require("plugins.heirline.disable").disable_statuscolumn({
      buftype = { "nofile", "terminal" },
    })

    require("heirline").setup({
      statusline = require("plugins.heirline.statusline"),
      winbar = require("plugins.heirline.winbar"),
      statuscolumn = require("plugins.heirline.statuscolumn"),
      opts = {
        colors = require("plugins.heirline.components.colors"),
        disable_winbar_cb = function(args)
          local buf = args.buf
          if vim.api.nvim_buf_is_valid(buf) then
            local buftype = vim.tbl_contains({ "prompt", "nofile", "quickfix" }, vim.bo[buf].buftype)
            local filetype =
              vim.tbl_contains({ "gitcommit", "FUGITIVE", "Trouble", "packer", "toggleterm" }, vim.bo[buf].filetype)
            return buftype or filetype
          else
            return true
          end
        end,
      },
    })

    vim.api.nvim_create_user_command("ReloadStatusColum", function()
      vim.o.statuscolumn = "%{%v:lua.require'heirline'.eval_statuscolumn()%}"
    end, {})
  end,
}
