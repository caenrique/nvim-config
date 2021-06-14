lua require('plugins')
lua require("options")
lua require("settings.nvim-metals")
lua require("settings.colorscheme")
lua require("settings.lualine")
lua require("settings.auto-session")
lua require("settings.nvim-treesitter")
lua require("settings.nvim-compe")
lua require('settings.nvim-autopairs')
" lua require('settings.onedark')

autocmd BufWritePost plugins.lua PackerCompile

runtime! functions.vim
runtime! commands.vim
runtime! keymappings.vim

let &fcs='eob: '
