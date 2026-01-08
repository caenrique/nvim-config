return {
  'Bekaboo/dropbar.nvim',
  config = function(_, opts)
    local default_config = require('dropbar.configs').opts
    opts.bar = {
      enable = function(buf, win, info)
        -- Check if we are in a vscode-diff tabpage and disable winbar
        local tab = vim.api.nvim_win_get_tabpage(win)
        local ok, lifecycle = pcall(require, 'vscode-diff.render.lifecycle')

        -- If we are in a vscode-diff tabpage, disable winbar
        if ok and lifecycle.get_session(tab) then return false end

        -- Fallback to the default implementation
        return default_config.bar.enable(buf, win, info)
      end,
    }

    require('dropbar').setup(opts)
  end,
  opts = {
    sources = {
      path = {
        max_depth = 1,
        modified = function(sym)
          return sym:merge({
            name = sym.name,
            icon = '[󱇬] ',
            name_hl = 'NeoTreeModified',
            icon_hl = 'NeoTreeModified',
          })
        end,
      },
      lsp = {
        max_depth = 10,
      },
      treesitter = {
        max_depth = 10,
      },
    },
  },
}
