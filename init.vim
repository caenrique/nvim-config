lua require('plugins')
lua require("nvim-metals")
lua require("options")
lua require("settings.colorscheme")
lua require("settings.lualine")
lua require("settings.auto-session")
lua require("settings.nvim-treesitter")

autocmd BufWritePost plugins.lua PackerCompile

source functions.vim
source commands.vim
source keymappings.vim

let &fcs='eob: '
