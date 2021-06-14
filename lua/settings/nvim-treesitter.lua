require'nvim-treesitter.configs'.setup {
  ensure_installed = { "scala", "bash", "lua", "java", "json", "dockerfile", "yaml" },
  highlight = {
    enable = true              -- false will disable the whole extension
  },
}
