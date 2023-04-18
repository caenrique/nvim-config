local utils = require('heirline.utils')

return {
    condition = function()
        return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
    end,
    provider = " ",
    hl = { fg = "orange", bold = true },
    utils.surround({ "[", "]" }, nil, {
        provider = function()
            return vim.fn.reg_recording()
        end,
        hl = { fg = "green", bold = true },
    }),
    update = {
        "RecordingEnter",
        "RecordingLeave",
        -- redraw the statusline on recording events
        -- Note: this is only required for Neovim < 0.9.0. Newer versions of
        -- Neovim ensure `statusline` is redrawn on those events.
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
     }
}
