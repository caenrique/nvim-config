return {
  "nvim-telescope/telescope.nvim",
  -- version = '0.1.*',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "softinio/scaladex.nvim",
    "olacin/telescope-cc.nvim",
    "mollerhoj/telescope-recent-files.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        preview = {
          hide_on_startup = true, -- hide previewer when picker starts
        },
        layout_strategy = "flex",
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        color_devicons = true,
        layout_config = {
          prompt_position = "top",
          flex = {
            flip_columns = 267,
            vertical = {
              width = { 0.9, min = 120 },
            },
            horizontal = {
              width = { 0.9, min = 240 },
            },
          },
        },
        path_display = {
          "filename_first",
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            ["<C-n>"] = require("telescope.actions.layout").cycle_layout_next,
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = function(prompt_bufnr)
              actions.smart_send_to_qflist(prompt_bufnr)
              actions.open_qflist(prompt_bufnr)
            end,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--hidden",
        },
      },
      pickers = {
        -- Your special builtin config goes in here
        buffers = {
          sort_lastused = true,
          -- theme = 'dropdown',
          previewer = false,
          mappings = {
            i = {
              ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
          },
        },
        quickfixhistory = {
          mappings = {
            i = {
              ["<CR>"] = function(prompt_bufnr)
                local nr = require("telescope.actions.state").get_selected_entry().nr
                actions.close(prompt_bufnr)
                vim.cmd(nr .. "chistory")
                vim.cmd("botright copen")
              end,
            },
          },
        },
        find_files = {
          find_command = { "rg", "--files", "--iglob", "!.git", "--iglob", "!.worktrees", "--hidden" },
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = {
            -- extend mappings
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-e>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
            },
          },
          additional_args = { "--hidden" },
        },
        ["recent-files"] = {
          -- find_command = { "rg", "--files", "--iglob", "!.git", "--iglob", "!.worktrees", "--hidden" },
          ignore_patterns = { ".git", ".worktrees" },
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("scaladex")
    require("telescope").load_extension("conventional_commits")
    require("telescope").load_extension("recent-files")

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      command = "setlocal number",
    })
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope").extensions["recent-files"].recent_files()
      end,
    },
    {
      "<leader>fd",
      function()
        local buffer_dir = vim.fn.expand("%:h")
        local cwd = vim.fn.getcwd()

        if buffer_dir ~= "" then
          cwd = buffer_dir
        end

        require("telescope.builtin").find_files({
          prompt_title = "Find in dir: " .. buffer_dir,
          cwd = cwd,
        })
      end,
    },
    {
      "<leader><leader>",
      function()
        require("telescope.builtin").resume()
      end,
    },

    -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim#grep-argument-examples
    {
      "<leader>fg",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
    },
    {
      "<leader>mc",
      function()
        require("telescope").extensions.metals.commands()
      end,
    },
    {
      "<leader>Q",
      function()
        require("telescope.builtin").quickfixhistory()
      end,
    },
    {
      "<leader>cc",
      function()
        require("telescope").extensions.conventional_commits.conventional_commits()
      end,
    },
  },
}
