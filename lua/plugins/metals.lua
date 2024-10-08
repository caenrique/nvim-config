return {
  "scalameta/nvim-metals",
  name = "metals",
  config = function()
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

    local function metals_keymaps(bufnr)
      vim.keymap.set("n", "<leader>ws", require("metals").hover_worksheet, { buffer = bufnr })
      vim.keymap.set("n", "<leader>sf", require("metals").run_scalafix, { buffer = bufnr })
      vim.keymap.set("n", "<leader>i", require("metals").organize_imports, { buffer = bufnr })
      vim.keymap.set("n", "<leader>tv", require("metals.tvp").toggle_tree_view, { buffer = bufnr })
      vim.keymap.set("n", "<leader>tr", require("metals.tvp").reveal_in_tree, { buffer = bufnr })

      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, { buffer = bufnr })

      vim.api.nvim_create_user_command(
        "ScalaPackage",
        require("telescope").extensions.scaladex.scaladex.search,
        { desc = "Search scala dependencies" }
      )
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities()) or {}
    end

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local metals_config = require("metals").bare_config()

    metals_config.capabilities = capabilities
    metals_config.init_options.statusBarProvider = "on"
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      enableSemanticHighlighting = true,
      defaultBspToBuildTool = true,
      autoImportBuild = "all",
    }

    metals_config.on_attach = function(client, bufnr)
      require("caenrique.lsp").setup_lsp_mappings(client, bufnr)
      require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
      metals_keymaps(bufnr)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
