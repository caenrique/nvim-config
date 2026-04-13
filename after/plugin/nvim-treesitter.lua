Cesar.require('nvim-treesitter', {
  func = 'install',
  opts = {
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'scala',
    'pkl',
    'tmux',
    'http',
  },
  after = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if lang and vim.treesitter.language.add(lang) then
          vim.treesitter.start(ev.buf, lang)
        end
      end,
    })
  end,
})
