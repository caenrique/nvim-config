if not pcall(require, 'possession') then
    return
end

vim.o.sessionoptions = 'curdir,tabpages,winsize'

require('telescope').load_extension('possession')

require('possession').setup {
    autosave = {
        current = true,
    },
    hooks = {
        after_load = function(name, _)
            if string.find(name, "scala") then
                vim.cmd.clearjumps()
                require('metals').restart_server()
            end
        end,
    },
    commands = {
        save = 'SessionSave',
        load = 'SessionLoad',
        close = 'SessionClose',
        delete = 'SessionDelete',
        show = 'SessionShow',
        list = 'SessionList',
        migrate = 'SessionMigrate',
    },
    plugins = {
        close_windows = {
            match = {
                filetype = { 'neo-tree' },
                buftype = { 'terminal' },
            },
        },
        delete_hidden_buffers = {
            hooks = {
                'before_load',
                vim.o.sessionoptions:match('buffer') and 'before_save',
            },
            force = true, -- or fun(buf): boolean
        },
        delete_buffers = true,
    },
}

vim.keymap.set('n', '<C-P>', require('telescope').extensions.possession.list, { silent = true })
