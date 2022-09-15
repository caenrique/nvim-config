local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

opt.formatoptions = opt.formatoptions
    - 'a' -- Auto formatting is BAD.
    - 't' -- Don't auto format my code. I got linters for that.
    + 'c' -- In general, I like it when comments respect textwidth
    + 'q' -- Allow formatting comments w/ gq
    - 'o' -- O and o, don't continue comments
    + 'r' -- But do continue when pressing enter.
    + 'n' -- Indent past the formatlistpat, not underneath it.
    + 'j' -- Auto-remove comments if possible.
    - '2' -- I'm not in gradeschool anymore

--opt.diffopt = opt.diffopt + ",algorithm:minimal,vertical,iwhiteall,iblank"

opt.autowrite = true
opt.autowriteall = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.showmode = false
opt.splitright = true
opt.splitbelow = true
opt.number = true
opt.lazyredraw = true
opt.linebreak = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 5

opt.inccommand = 'split'
opt.clipboard = 'unnamed'
opt.mouse = 'a'
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.shiftround = true
opt.list = true
opt.conceallevel = 0
opt.undofile = true
opt.undodir = vim.env.HOME .. '/.config/nvim/history'
opt.cmdheight = 0
opt.updatetime = 1000
opt.termguicolors = true

opt.breakindent = true

vim.api.nvim_set_option('fcs', 'eob: ') -- Remove the ~ from left column on EndOfBuffer (empty lines at the end of file)
