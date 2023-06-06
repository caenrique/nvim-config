vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

vim.o.formatoptions = 'jrn'

vim.o.autowrite = true
vim.o.autowriteall = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.showmode = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.lazyredraw = true
vim.o.linebreak = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 3

vim.o.inccommand = 'split'
vim.o.clipboard = 'unnamed'
vim.o.mouse = 'a'
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.list = true
vim.o.conceallevel = 0
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('config') .. '/history'
vim.o.cmdheight = 0
vim.o.updatetime = 250
vim.o.termguicolors = true
vim.o.hidden = true

vim.o.breakindent = true

vim.opt_global.shortmess:append('c')

vim.api.nvim_set_option('fcs', 'eob: ') -- Remove the ~ from left column on EndOfBuffer (empty lines at the end of file)

vim.opt.guicursor = {
  'n-c-ve-v:hor30',
  'i-ci:ver30',
  'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}

-- Do not load matchit plugin that comes bundled with neovim. It creates mappings that interfere with my own and I don't use it
vim.g.loaded_matchit = true

-- Fold options
vim.o.foldcolumn = 'auto'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true


-- Diff options
vim.g.diff_translations = false
vim.opt.diffopt = {
  'internal',
  'linematch:60',
  'algorithm:histogram',
  'indent-heuristic'
}
