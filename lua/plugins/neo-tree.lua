return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          hint = "floating-big-letter",
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
          show_promp = false,
        })
      end,
    },
  },
  config = function()
    local fc = require("neo-tree.sources.filesystem.components")

    require("neo-tree").setup({
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        container = {
          enable_character_fade = true,
          width = "100%",
          right_padding = 0,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          -- indent guides
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "ﰊ",
          folder_empty_open = "ﰊ",
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
        modified = {
          symbol = "",
        },
        name = {
          highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
        },
        git_status = {
          symbols = {
            -- Change type
            added = "", -- NOTE: you can set any of these to an empty string to not show them
            deleted = "",
            modified = "",
            renamed = "",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
          align = "left",
        },
      },
      renderers = {
        directory = {
          { "indent" },
          { "icon" },
          { "current_filter" },
          {
            "container",
            content = {
              { "name", zindex = 10 },
              -- {
              --   "symlink_target",
              --   zindex = 10,
              --   highlight = "NeoTreeSymbolicLinkTarget",
              -- },
              { "clipboard", zindex = 10 },
              { "diagnostics", errors_only = true, zindex = 10, align = "left", hide_when_expanded = true },
              -- { 'git_status', zindex = 10, align = 'left', hide_when_expanded = true },
            },
          },
        },
        file = {
          { "indent" },
          -- { 'git_status', zindex = 15, align = 'left' },
          { "icon" },
          {
            "container",
            content = {
              {
                "name",
                zindex = 10,
              },
              { "clipboard", zindex = 10 },
              { "bufnr", zindex = 10 },
              { "git_status", zindex = 10, align = "left" },
              { "modified", zindex = 10, align = "left" },
              { "diagnostics", zindex = 10, align = "left" },
            },
          },
        },
      },
      window = {
        width = 50,
        mappings = {
          ["s"] = "open_vsplit",
          ["S"] = "open_split",
          ["o"] = "open",
        },
      },
      filesystem = {
        components = {
          name = function(config, node, state)
            local result = fc.name(config, node, state)
            if node:get_depth() == 1 and node.type ~= "message" and string.len(result.text) >= 50 then
              result.text = vim.fn.fnamemodify(node.path, ":t")
            elseif node.type ~= "message" and string.len(result.text) >= 40 then
              result.text = vim.fn.pathshorten(node.name, 3)
            end
            return result
          end,
        },
        filtered_items = {
          visible = true,
          always_show = {
            ".gitignore",
            ".scalafmt.conf",
            ".scalafix.conf",
            ".github",
          },
          never_show = {
            ".bloop",
            ".bsp",
            ".metals",
            ".git",
            ".idea",
            ".ruby-version",
            "node_modules",
            "history",
          },
        },
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
        follow_current_file = true,
      },
    })
  end,
  keys = {
    {
      "<C-n>",
      function()
        require("neo-tree.command").execute({
          source = "filesystem",
          position = "left",
          toggle = true,
          reveal = true,
        })
      end,
    },
    {
      "<C-b>",
      function()
        require("neo-tree.command").execute({
          source = "buffers",
          position = "left",
          toggle = true,
          reveal = true,
        })
      end,
    },
  },
}
