return {
  'comfysage/artio.nvim',
  lazy = false,
  opts = {
    mappings = {
      ['<down>'] = 'down',
      ['<up>'] = 'up',
      ['<c-j>'] = 'down',
      ['<c-k>'] = 'up',
      ['<cr>'] = 'accept',
      ['<esc>'] = 'cancel',
      ['<tab>'] = 'mark',
      ['<m-l>'] = 'togglelive',
      ['<m-p>'] = 'togglepreview',
      ['<c-q>'] = 'setqflist',
      ['<m-q>'] = 'setqflistmark',
    },
    win = {
      height = 16,
      hidestatusline = true,
      preview_opts = function(view)
        local item = view.picker.items[view.picker.matches[view.picker.idx][1]].text
        return {
          title = string.format('[%s/%s]: %s', view.picker.idx, #view.picker.matches, item),
        }
      end,
    },
  },
  config = function(_, opts)
    require('artio').setup(opts)

    local findprg =
      [[ fd --hidden --full-path --absolute-path --type file --color=never --exclude node_modules --exclude .git]]

    local format_file = function(item)
      local path = vim.fs.relpath(vim.fn.getcwd(), item) or item
      local dir, file = vim.fs.dirname(path), vim.fs.basename(path)
      return string.format('%s %s', file, dir ~= '.' and dir or '')
    end

    local highlight_file = function(item)
      local i = #vim.fs.basename(item.v)

      return {
        { { 0, i }, 'ArtioNormal' },
        { { i + 1, #item.text }, 'NonText' },
      }
    end

    -- override built-in ui select with artio
    vim.ui.select = require('artio').select

    -- vim.keymap.set('n', '<leader>af', '<Plug>(artio-files)')
    vim.keymap.set('n', '<leader>ag', '<Plug>(artio-grep)')

    -- smart file picker
    vim.keymap.set('n', '<leader>as', '<Plug>(artio-smart)')

    -- general built-in pickers
    vim.keymap.set('n', '<leader>ah', '<Plug>(artio-helptags)')
    -- vim.keymap.set('n', '<leader>ab', '<Plug>(artio-buffers)')
    vim.keymap.set('n', '<leader>a/', '<Plug>(artio-buffergrep)')
    vim.keymap.set('n', '<leader>ao', '<Plug>(artio-oldfiles)')

    vim.cmd('highlight! link ArtioMatch SnacksPickerMatch')

    vim.keymap.set('n', '<leader>af', function()
      ---@diagnostic disable-next-line: missing-fields
      require('artio.builtins').files({
        findprg = findprg,
        format_item = format_file,
        hl_item = highlight_file,
        get_icon = function(item) return require('mini.icons').get('file', item.v) end,
      })
    end)

    vim.keymap.set('n', '<leader>ab', function()
      ---@diagnostic disable-next-line: missing-fields
      require('artio.builtins').buffers({
        format_item = function(bufnr)
          local buf_name = vim.api.nvim_buf_get_name(bufnr)
          local path = vim.fs.relpath(vim.fn.getcwd(), buf_name) or buf_name
          local dir, file = vim.fs.dirname(path), vim.fs.basename(path)
          return string.format('%s %s', file, dir ~= '.' and dir or '')
        end,
        hl_item = function(item)
          local i = #vim.fs.basename(vim.api.nvim_buf_get_name(item.v))

          return {
            { { 0, i }, 'SnacksPickerFile' },
            { { i + 1, #item.text }, 'SnacksPickerDir' },
          }
        end,
        get_icon = function(item)
          local buf_name = vim.api.nvim_buf_get_name(item.v)
          return require('mini.icons').get('file', buf_name)
        end,
      })
    end)
  end,
}
