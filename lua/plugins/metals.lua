return {
  'scalameta/nvim-metals',
  name = 'metals',
  dependencies = 'mfussenegger/nvim-dap',
  config = function()
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })

    local function metals_keymaps(bufnr)
      vim.keymap.set('n', '<leader>ws', require('metals').hover_worksheet, { buffer = bufnr })
      vim.keymap.set('n', '<leader>sf', require('metals').run_scalafix, { buffer = bufnr })
      vim.keymap.set('n', '<leader>i', require('metals').organize_imports, { buffer = bufnr })
      vim.keymap.set('n', '<leader>tv', require('metals.tvp').toggle_tree_view, { buffer = bufnr })
      vim.keymap.set('n', '<leader>tr', require('metals.tvp').reveal_in_tree, { buffer = bufnr })
    end

    local function organize_imports_autocmd(bufnr)
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = require('metals').organize_imports,
        group = nvim_metals_group,
        buffer = bufnr,
      })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if pcall(require, 'cmp_nvim_lsp') then
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    end

    local metals_config = require('metals').bare_config()

    metals_config.capabilities = capabilities
    metals_config.init_options.statusBarProvider = 'on'
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
      enableSemanticHighlighting = true,
    }

    metals_config.on_attach = function(client, bufnr)
      require('caenrique.lsp').setup_lsp_mappings(client, bufnr)
      metals_keymaps(bufnr)
      -- organize_imports_autocmd(bufnr)
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'scala', 'sbt', 'java' },
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
