Cesar.require('mason-tool-installer', {
  opts = {
    ensure_installed = {
      'lua-language-server',
      'yaml-language-server',
      'typescript-language-server',
      'json-lsp',
      'markdown-oxide',
      'pkl-lsp',
      'stylua', -- Used to format Lua code
      'zk', -- note taking cli tool
      'rust-analyzer',
      'terraform-ls',
      'jdtls',
      'lemminx',
      'html-lsp',
    },
  }
})

Cesar.require('lspconfig', {
  after = function()
    --Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config('html', {
      capabilities = capabilities,
    })

    vim.lsp.enable({
      'lua_ls',
      'yamlls',
      'jsonls',
      'markdown_oxide',
      'ts_ls',
      'terraformls',
      'lemminx',
      'pkl_ls',
      'html',
    })

    -- pkl-lsp config
    vim.g.pkl_neovim = {
      start_command = { vim.fn.stdpath('data') .. '/mason/bin/' .. 'pkl-lsp' },
      pkl_cli_path = vim.fn.stdpath('data') .. '/mason/packages/',
    }
  end,
})

Cesar.require('conform', {
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      local disable_filetypes = { c = false, cpp = false }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
  after = function()

    vim.keymap.set('n', '<C-f>', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
      { desc = '[F]ormat buffer' })

    vim.api.nvim_create_user_command('FormatDisable', function()
      vim.g.disable_autoformat = true
    end, {
      desc = 'Disable autoformat-on-save',
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end
})
