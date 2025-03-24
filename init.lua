-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Diff options
vim.g.diff_translations = false
vim.opt.diffopt = {
  'internal',
  'closeoff',
  'filler',
  -- "linematch:60",
  'algorithm:myers',
  -- "indent-heuristic",
}

vim.opt_global.fillchars:append({
  eob = ' ',
  fold = ' ',
})

vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.o.cmdheight = 0

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Insert spaces instead of tabs
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true

-- auto write, no backups
vim.o.autowrite = true
vim.o.autowriteall = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Persistent undo history
vim.o.undofile = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

require('caenrique.lazy') -- setup for lazy.nvim package manager

vim.cmd.colorscheme('catppuccin')

-- vim.keymap.set('n', '<leader>r', require('caenrique.config.scala-cli-test-runner').run_test_file)
vim.keymap.set('n', '<leader>Tw', require('caenrique.scala-cli-test-runner').run_tests_workspace)
vim.keymap.set('n', '<leader>Ts', require('caenrique.scala-cli-test-runner').run_test_file)
