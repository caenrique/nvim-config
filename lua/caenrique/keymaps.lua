-- vim.keymap.set({ "v", "x" }, "<C-d>", function()
--   local view = vim.fn.winsaveview()
--   vim.print(view)
--   local key = vim.api.nvim_replace_termcodes("<C-d>", true, false, true)
--   vim.cmd.normal({ args = { key }, bang = true })
--   vim.fn.winrestview({ topline = view.topline })
-- end, {})
--
-- vim.keymap.set({ "v", "x" }, "<C-u>", function()
--   local view = vim.fn.winsaveview()
--   vim.print(view)
--   local key = vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
--   vim.cmd.normal({ args = { key }, bang = true })
--   vim.fn.winrestview({ topline = view.topline })
-- end)
--
-- vim.keymap.set("n", "<C-h>", function()
--   vim.cmd.normal("*")
--   local word_under_cursor = vim.fn.getreg("/")
--   vim.print(word_under_cursor)
--   vim.cmd.help(word_under_cursor)
-- end)

vim.keymap.set("x", "p", 'p:let @"=@0<CR>', { silent = true })
vim.keymap.set("n", "<C-p>", '"0p')

vim.keymap.set("n", "<leader><esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "th", ":tabprev<CR>")
vim.keymap.set("n", "tl", ":tabnext<CR>")
vim.keymap.set("n", "td", ":tabclose<CR>")
vim.keymap.set("n", "gh", "<C-W>h")
vim.keymap.set("n", "gl", "<C-W>l")
vim.keymap.set("n", "gk", "<C-W>k")
vim.keymap.set("n", "gj", "<C-W>j")
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')
vim.keymap.set("n", "<C-6>", "<C-^>")

vim.keymap.set({ "n", "v" }, "j", "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ "n", "v" }, "k", "v:count ? 'k' : 'gk'", { expr = true })

vim.keymap.set("v", "[", '"ss[<C-R>s]<esc>')
vim.keymap.set("v", "{", '"ss{<C-R>s}<esc>')
vim.keymap.set("v", "(", '"ss(<C-R>s)<esc>')
vim.keymap.set("v", '<leader>"', '"ss"<C-R>s"<esc>')
vim.keymap.set("v", "'", '"ss\\"<C-R>s\\"<esc>')
vim.keymap.set("v", "`", '"ss`<C-R>s`<esc>')

vim.keymap.set("n", "<leader><Tab>", "za")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "x" }, "<leader>p", '"*p')
vim.keymap.set("x", "<leader>y", '"*y')
vim.keymap.set("n", "<leader>yy", '"*yy')

-- TODO: Find a proper mapping for next/previous occurence for a find command (find in line with f). It's slow because I use `;` for other mappings
--
vim.keymap.set("n", "<C-q>", "q")
-- Enable againg but only when buftype is empty
vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>")

vim.keymap.set("i", "<C-BS>", "col('.') == 1 ? '<C-W><C-F>' : '<C-W>'", { expr = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function(args)
    vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = args.buf })
  end,
})
