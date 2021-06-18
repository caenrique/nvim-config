require('utils')
local cmd = vim.cmd
local g = vim.g


-- nvim-metals
g["metals_server_version"] = "0.10.2+46-e7ab8592-SNAPSHOT"

-- global
vim.opt_global.completeopt = { "menu", "noinsert", "noselect" }
vim.opt_global.shortmess:remove("F"):append("c")

-- LSP
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>ws", '<cmd>lua require"metals".worksheet_hover()<CR>')
map("n", "<leader>a", '<cmd>lua require"metals".open_all_diagnostics()<CR>')
map("n", "<leader>k", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
map("n", "<leader>q", '<cmd>cclose<CR>')
map("n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>") -- buffer diagnostics only
map("n", ";N", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", ";n", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])

-- Example mappings for usage with nvim-dap. If you don't use that, you can skip these
map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n", "<leader>ds", [[<cmd>lua require"dap.ui.variables".scopes()<CR>]])
map("n", "<leader>dtb", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])

-- completion related settings
-- This is similiar to what I use
require("compe").setup({
  enabled = true,
  debug = false,
  min_length = 1,

  source = {
    path = true,
    buffer = true,
    vsnip = {
      filetypes = { "scala", "sbt", "java" },
    },
    nvim_lsp = {
      priority = 1000,
      filetypes = { "scala", "sbt", "java" },
    },
  },
})

map("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
map("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
map("i", "<CR>", 'compe#confirm("\\<CR>")', { expr = true })

----------------------------------
-- COMMANDS ----------------------
----------------------------------
-- LSP
cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
cmd([[augroup end]])

-- Need for symbol highlights to work correctly
vim.cmd([[hi! link LspReferenceText CursorColumn]])
vim.cmd([[hi! link LspReferenceRead CursorColumn]])
vim.cmd([[hi! link LspReferenceWrite CursorColumn]])
----------------------------------
-- LSP Setup ---------------------
----------------------------------
metals_config = require("metals").bare_config

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  showInferredType = true,
}

-- Example of how to ovewrite a handler
metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = { prefix = "" },
})

-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
metals_config.init_options.statusBarProvider = "on"

-- Example if you are including snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

metals_config.capabilities = capabilities

-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "Run",
    metals = {
      runType = "run",
      args = { "firstArg", "secondArg", "thirdArg" },
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test File",
    metals = {
      runType = "testFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
  require("lsp_signature").on_attach()
end
