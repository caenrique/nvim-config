require("caenrique.options")
require("caenrique.diagnostic")
require("caenrique.keymaps")
require("caenrique.commands")
require("caenrique.lsp")
require("caenrique.filetypes")

require("caenrique.sbt-test-results-quickfix")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  dev = {
    -- directory where you store your local plugin projects
    path = "~/Projects/github.com/caenrique",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
})
