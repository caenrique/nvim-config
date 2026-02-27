return {
  'Bekaboo/dropbar.nvim',
  opts = {
    bar = {
      enable = function(buf, win, _)
        buf = vim._resolve_bufnr(buf)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then return false end

        if
          not vim.api.nvim_buf_is_valid(buf)
          or not vim.api.nvim_win_is_valid(win)
          or vim.fn.win_gettype(win) ~= ''
          or vim.wo[win].winbar ~= ''
          or vim.bo[buf].ft == 'help'
        then
          return false
        end

        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
        if stat and stat.size > 1024 * 1024 then return false end

        return true
        -- return vim.bo[buf].ft == 'markdown'
        --   or pcall(vim.treesitter.get_parser, buf)
        --   or not vim.tbl_isempty(vim.lsp.get_clients({
        --     bufnr = buf,
        --     method = 'textDocument/documentSymbol',
        --   }))
      end,
      sources = function(buf, _)
        local sources = require('dropbar.sources')
        local utils = require('dropbar.utils')
        if vim.bo[buf].ft == 'markdown' then return {
          sources.path,
          sources.markdown,
        } end
        if vim.bo[buf].buftype == 'terminal' then return {
          sources.terminal,
        } end
        return {
          sources.path,
          utils.source.fallback({
            sources.lsp,
            sources.treesitter,
          }),
        }
      end,
    },
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
        max_depth = 5,
      },
      treesitter = {
        max_depth = 5,
      },
    },
  },
}
