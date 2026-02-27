local bufnr = vim.api.nvim_get_current_buf()

-- overrides the default code action to
-- support rust-analyzer's grouping
vim.keymap.set('n', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end, { silent = true, buffer = bufnr })

-- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
vim.keymap.set('n', 'K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, { silent = true, buffer = bufnr })
