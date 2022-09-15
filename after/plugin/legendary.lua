if not pcall(require, 'legendary') then
    return
end

local function addDefaultOpts(maps)
    for _, v in ipairs(maps) do
        v.opts = { silent = true, noremap = true }
    end
    return maps
end

local keymaps = {
    { '<leader><space>', ':nohlsearch<CR>', description = 'Clear the search hightlight' },
    { '<leader><tab>', 'za', description = 'Toggle folds' },
    { 'th', ':tabprev<CR>', description = 'Go to previous tab' },
    { 'tl', ':tabnext<CR>', description = 'Go to next tab' },
    { 'td', ':tabclose<CR>', description = 'Close current tab' },
    { 'gh', '<C-W>h', description = 'Go to windown on the left' },
    { 'gl', '<C-W>l', description = 'Go to windown on the right' },
    { 'gk', '<C-W>k', description = 'Go to windown on the top' },
    { 'gj', '<C-W>j', description = 'Go to windown on the bottom' },
    {
        '.',
        ":'<,'>call funtions#Repeat_with_visual_selection()<CR>",
        description = 'Repeat last edit for each line of the visual selection',
        mode = { 'v' },
    },
    { '<C-p>', '"0p', description = 'paste from the copy register', mode = { 'v', 'n' } },
    {
        '<C-r>',
        '"hy:%s/<C-r>h//gc<left><left><left>',
        description = 'Use the visual selection as the search term in a replace command (:s)',
        mode = { 'v' },
    },
    { '<C-6>', '<C-^>', description = 'Make C-6 the same as C-^' },

    -- Neotree
    { '<C-n>', ':Neotree filesystem toggle<CR>', mode = { 'n', 'v' }, description = 'Toggle NeoTree filesystem pane' },
    { '<C-b>', ':Neotree buffers toggle<CR>', mode = { 'n', 'v' }, description = 'Toggle NeoTree open buffers pane' },

    -- Toggle Terminal
    { '<C-/>', ':ToggleTerminal<CR>', description = 'Open terminal buffer' },
    { '<C-/>', '<C-\\><C-n>:ToggleTerminal<CR>', mode = { 't' }, description = 'Close terminal buffer' },
    { '<Esc>', '<C-\\><C-n>', mode = { 't' }, description = 'Go to normal mode while on terminal buffer' },

    -- Trouble
    { 'tt', '<cmd>TroubleToggle<CR>', description = 'Toggle Trouble window' },
    { '<leader>d', '<cmd>Trouble document_diagnostics<CR>', description = 'Open trouble document_diagnostics' },
    { '<leader>D', '<cmd>Trouble workspace_diagnostics<CR>', description = 'Open trouble workspace_diagnostics' },
    { '<leader>tq', '<cmd>Trouble quickfix<CR>', description = 'Open trouble quickfix' },
    { '<leader>tl', '<cmd>Trouble loclist<CR>', description = 'Open trouble loclist' },
    { '<leader>qq', '<cmd>Trouble todo<CR>', description = 'Open trouble todo' },
    {
        '<leader>n',
        function()
            require('trouble').next({ skip_groups = true, jump = true })
        end,
        description = 'Go to next diagnostic line in trouble window',
    },
    {
        '<leader>p',
        function()
            require('trouble').previous({ skip_groups = true, jump = true })
        end,
        description = 'Go to previous diagnostic line in trouble window',
    },
    { 'ma', 'mA' },
    { 'ms', 'mS' },
    { 'md', 'mD' },
    { 'mf', 'mF' },
    { "'a", "'A" },
    { "'s", "'S" },
    { "'d", "'D" },
    { "'f", "'F" },

    -- nvim_toggle_terminal#Toggle('t:terminal')
    {
        ';a',
        function()
            vim.call('nvim_toggle_terminal#Toggle', 'g:terminal_a')
        end,
        mode = { 'n', 't' },
    },
    {
        ';s',
        function()
            vim.call('nvim_toggle_terminal#Toggle', 'g:terminal_s')
        end,
        mode = { 'n', 't' },
    },
    {
        ';d',
        function()
            vim.call('nvim_toggle_terminal#Toggle', 'g:terminal_d')
        end,
        mode = { 'n', 't' },
    },
    {
        ';f',
        function()
            vim.call('nvim_toggle_terminal#Toggle', 'g:terminal_f')
        end,
        mode = { 'n', 't' },
    },
    {
        ';;',
        function()
            vim.call('nvim_toggle_terminal#CloseAny')
        end,
        mode = { 't', 'n' },
    },
    {
        '<C-m>',
        '<cmd>MindOpenMain<CR>',
        mode = 'n',
    }
}

require('legendary').setup({
    keymaps = addDefaultOpts(keymaps),
    commands = {
        {
            ':Scratch',
            function()
                require('caenrique.functions').scratch_buffer({ open = 'split' })
            end,
            description = 'Open a scratch buffer',
        },
    },
    autocmds = nil,
})
