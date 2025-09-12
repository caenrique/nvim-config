return {
  'zk-org/zk-nvim',
  name = 'zk',
  opts = {
    -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
    -- or select" (`vim.ui.select`).
    picker = 'snacks_picker',
  },

  config = function(_, opts)
    require('zk').setup(opts)
    local util = require('zk.util')

    local get_selected_text = function()
      local mode = vim.api.nvim_get_mode().mode
      local opts = {}
      -- \22 is an escaped version of <c-v>
      if mode == 'v' or mode == 'V' or mode == '\22' then
        opts.type = mode
        local selected = vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', opts)
        return selected
      end
      return nil
    end

    --- @enum note_type
    local NOTE_TYPE = {
      default = 'default',
      daily = 'daily',
      source = 'source',
      postmortem = 'postmortem',
    }

    --- @class CreateNoteParams
    --- @field insertLink? boolean
    --- @field edit? boolean
    --- @field type? note_type
    --- @field tags? string[]

    --- Create a new note
    --- @param params? CreateNoteParams
    local function create_note(params)
      params = params or {}

      local selected_text = get_selected_text()
      vim.ui.input({ prompt = 'Note title:' }, function(title)
        if title == nil or title == '' then return end

        local cleaned_title = title:gsub('%s+#.*$', '')

        local commandOptions = {
          title = cleaned_title,
          edit = true,
          -- group = NOTE_TYPE.default,
          insertLinkAtLocation = util.get_lsp_location_from_caret(),
        }

        if params.edit ~= nil then commandOptions.edit = params.edit end
        if params.type ~= nil then commandOptions.group = params.type end
        if params.insertLink ~= nil and not params.insertLink then commandOptions.insertLinkAtLocation = nil end

        if selected_text ~= nil then
          commandOptions.content = table.concat(selected_text, '\n')
          if commandOptions.insertLinkAtLocation ~= nil then
            commandOptions.insertLinkAtLocation = util.get_lsp_location_from_selection()
          end
        end

        local tags = params.tags or {}
        for tag in title:gmatch('%s+(#%S+)') do
          table.insert(tags, tag)
        end

        if next(tags) ~= nil then commandOptions.extra = { tags = table.concat(tags, ' ') } end

        vim.notify(vim.inspect(commandOptions))

        local path = nil
        if params.type == NOTE_TYPE.daily then path = vim.fn.expand('~') .. '/Notes/daily' end

        vim.notify(path)

        require('zk.api').new(path, commandOptions, function(err, res)
          if err then
            vim.notify(vim.inspect(err))
          else
            vim.notify('Note created at ' .. res.path)
          end
        end)
      end)
    end

    vim.api.nvim_create_user_command(
      'Note',
      function(params)
        create_note({
          insertLink = not params.bang,
          edit = not params.smods.silent,
          selection = params.range > 0,
        })
      end,
      { range = true, bang = true, nargs = '*' }
    )

    vim.keymap.set(
      'n',
      '<leader>sn',
      function() require('zk').edit({ sort = { 'created-' } }) end,
      { desc = 'Notes: [S]each [N]otes' }
    )
    vim.keymap.set(
      'n',
      '<leader>ng',
      function() Snacks.picker.grep({ cwd = vim.fn.expand('~') .. '/Notes', title = 'Grep Notes' }) end,
      { desc = '[N]otes: [G]rep Notes' }
    )
    vim.keymap.set(
      'n',
      '<leader>nd',
      function() require('zk').new({ dir = 'daily', group = 'daily' }) end,
      { desc = '[N]otes: Open a [D]aily note for today' }
    )
    vim.keymap.set(
      { 'n', 'x', 'v' },
      '<leader>nn',
      create_note,
      { desc = '[N]otes: Create a new [N]ote and insert a link here' }
    )
    vim.keymap.set(
      { 'n', 'x', 'v' },
      '<leader>nN',
      function() create_note({ insertLink = false }) end,
      { desc = '[N]otes: Create a new [N]ote without inserting a link' }
    )
    vim.keymap.set(
      { 'n', 'x', 'v' },
      '<leader>ns',
      function() create_note({ type = NOTE_TYPE.source }) end,
      { desc = '[N]otes: Create a new [S]ource note' }
    )
    vim.keymap.set('n', '<leader>nl', ':ZkInsertLink<CR>', { desc = '[N]otes: Insert a [L]ink' })
    vim.keymap.set('n', '<leader>nt', ':ZkTags<CR>', { desc = '[N]otes: search by [T]ag' })
  end,
}
