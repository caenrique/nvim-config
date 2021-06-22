lua require('plugins')
lua require("options")
lua require("settings.nvim-metals")
lua require("settings.tokyonight")
lua require("settings.lualine")
lua require("settings.auto-session")
lua require("settings.nvim-treesitter")
lua require("settings.nvim-compe")
lua require('settings.nvim-autopairs')
lua require('gitsigns').setup()
lua require('settings.telescope')
lua require('settings.fugitive')
lua require('settings.neogit')
lua require('settings.sqls')

autocmd BufWritePost plugins.lua PackerCompile

runtime! functions.vim
runtime! commands.vim
runtime! keymappings.vim

let &fcs='eob: ' " Remove the ~ from left column on EndOfBuffer (empty lines at the end of file)
