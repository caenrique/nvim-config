lua require('plugins')
autocmd BufWritePost plugins.lua PackerCompile

lua require("options")

map <Space> <Leader>

source keymappings.vim
source commands.vim

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "scala", "bash", "lua", "java", "json" },
  highlight = {
    enable = true              -- false will disable the whole extension
  },
}
EOF
