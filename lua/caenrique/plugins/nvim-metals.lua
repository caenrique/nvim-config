return {
  'scalameta/nvim-metals',
  dependencies = 'nvim-lua/plenary.nvim',
  dev = false,
  ft = { 'scala', 'sbt', 'java' },
  config = function()
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })

    local function metals_keymaps(bufnr)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'METALS: ' .. desc })
      end

      map('<leader>mws', require('metals').hover_worksheet, '[H]over [W]orksheet')
      map('<leader>msf', require('metals').run_scalafix, 'run [S]cala [F]ix')
      map('<leader>mi', require('metals').organize_imports, 'Organize [I]mports')
      map('<leader>mtv', require('metals.tvp').toggle_tree_view, 'Toggle [T]ree [V]iew')
      map('<leader>mtr', require('metals.tvp').reveal_in_tree, '[T]ree [R]eveal')
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local metals_config = require('metals').bare_config()

    metals_config.capabilities = capabilities
    metals_config.init_options.statusBarProvider = 'off'
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
      enableSemanticHighlighting = true,
      defaultBspToBuildTool = true,
      autoImportBuild = 'all',
      -- serverVersion = '1.4.2+80-2b937bb1-SNAPSHOT',
    }

    metals_config.on_attach = function(_, bufnr)
      metals_keymaps(bufnr)
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'scala', 'sbt', 'java' },
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
  keys = {
    {
      '<leader>mc',
      function()
        require('metals').commands()
      end,
      desc = 'Command palette for Metals',
    },
  },
}
