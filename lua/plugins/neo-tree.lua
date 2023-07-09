return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
    { 's1n7ax/nvim-window-picker', version = 'v1.*' }
  },
  config = function()
    local fc = require('neo-tree.sources.filesystem.components')
    local events = require('neo-tree.events')

    local function toggleGitAdd(state)
      local node = state.tree:get_node()
      if node.type == 'message' or node.type == 'directory' then
        return
      end
      local path = node:get_id()
      local git_status = node.extra.git_status
      if git_status:sub(1, 1) == ' ' or git_status:sub(1, 1) == '?' then
        local cmd = { 'git', 'add', path }
        vim.fn.system(cmd)
        events.fire_event(events.GIT_EVENT)
      else
        local cmd = { 'git', 'reset', '--', path }
        vim.fn.system(cmd)
        events.fire_event(events.GIT_EVENT)
      end
    end

    local function gitResetAll()
      local cmd = { 'git', 'reset', 'HEAD' }
      vim.fn.system(cmd)
      events.fire_event(events.GIT_EVENT)
    end

    require('neo-tree').setup({
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        container = {
          enable_character_fade = true,
          width = '100%',
          right_padding = 0,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          -- indent guides
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = 'ﰊ',
          folder_empty_open = 'ﰊ',
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = '*',
          highlight = 'NeoTreeFileIcon'
        },
        modified = {
          symbol = '',
        },
        name = {
          highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
        },
        git_status = {
          symbols = {
            -- Change type
            added     = '', -- NOTE: you can set any of these to an empty string to not show them
            deleted   = '',
            modified  = '',
            renamed   = '',
            -- Status type
            untracked = '',
            ignored   = '',
            unstaged  = '',
            staged    = '',
            conflict  = '',
          },
          align = 'left',
        },
      },
      renderers = {
        directory = {
          { 'indent' },
          { 'icon' },
          { 'current_filter' },
          {
            'container',
            content = {
              { 'name', zindex = 10 },
              -- {
              --   "symlink_target",
              --   zindex = 10,
              --   highlight = "NeoTreeSymbolicLinkTarget",
              -- },
              { 'clipboard', zindex = 10 },
              { 'diagnostics', errors_only = true, zindex = 10, align = 'left', hide_when_expanded = true },
              -- { 'git_status', zindex = 10, align = 'left', hide_when_expanded = true },
            },
          },
        },
        file = {
          { 'indent' },
          -- { 'git_status', zindex = 15, align = 'left' },
          { 'icon' },
          {
            'container',
            content = {
              {
                'name',
                zindex = 10
              },
              { 'clipboard', zindex = 10 },
              { 'bufnr', zindex = 10 },
              { 'git_status', zindex = 10, align = 'left' },
              { 'modified', zindex = 10, align = 'left' },
              { 'diagnostics', zindex = 10, align = 'left' },
            },
          },
        },
      },
      window = {
        width = 50,
        mappings = {
            ['O'] = 'open_vsplit',
            ['<C-o>'] = 'open_split',
            ['o'] = 'open',
        },
      },
      git_status = {
        window = {
          mappings = {
              ['<Tab>'] = toggleGitAdd,
              ['A'] = 'git_add_all',
              ['U'] = gitResetAll,
              ['u'] = 'git_unstage_file',
              ['s'] = 'git_add_file',
              ['gr'] = 'git_revert_file',
              ['cc'] = 'git_commit',
              ['c'] = 'none',
              ['gp'] = 'git_push',
              ['gg'] = 'git_commit_and_push',
          },
        },
      },
      filesystem = {
        components = {
          name = function(config, node, state)
            local result = fc.name(config, node, state)
            if node:get_depth() == 1 and node.type ~= 'message' and string.len(result.text) >= 50 then
              result.text = vim.fn.fnamemodify(node.path, ':t')
            elseif node.type ~= 'message' and string.len(result.text) >= 40 then
              result.text = vim.fn.pathshorten(node.name, 3)
            end
            return result
          end,
        },
        filtered_items = {
          visible = true,
          always_show = {
            '.gitignore',
            '.scalafmt.conf',
            '.scalafix.conf',
            '.github',
          },
          never_show = {
            '.bloop',
            '.bsp',
            '.metals',
            '.git',
            '.idea',
            '.ruby-version',
            'node_modules',
            'history'
          }
        },
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
        follow_current_file = true,
      }
    })
  end,
  keys = {
    { '<C-n>', function()
      require('neo-tree.command').execute({
        source = 'filesystem',
        position = 'left',
        toggle = true,
        reveal = true,
      })
    end
    },
    { '<C-b>', function()
      require('neo-tree.command').execute({
        source = 'buffers',
        position = 'left',
        toggle = true,
        reveal = true,
      })
    end
    },
    { '<C-g>', function()
      require('neo-tree.command').execute({
        source = 'git_status',
        position = 'left',
        toggle = true,
        reveal = true,
      })
    end
    },
  }
}
