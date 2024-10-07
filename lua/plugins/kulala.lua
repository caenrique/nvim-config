return {
  -- HTTP REST-Client Interface
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    config = function()
      -- Setup is required, even if you don't pass any options
      require("kulala").setup({
        additional_curl_options = { "--insecure" },
      })

      vim.api.nvim_create_user_command("Kulala", function()
        vim.cmd.tabnew()
        vim.cmd.tcd("~/Projects/ghe.siriusxm.com/http")
        require("neo-tree.command").execute({
          source = "filesystem",
          position = "left",
          toggle = true,
          reveal = true,
        })
      end, {})
    end,
    cmd = { "Kulala" },
    keys = {
      {
        "<CR>",
        function()
          require("kulala").run()
        end,
        ft = "http",
        desc = "Run request under the cursor",
      },
      {
        "K",
        function()
          require("kulala").copy()
        end,
        ft = "http",
        desc = "copy request as curl command",
      },
      -- {
      --   "<leader>ke",
      --   function()
      --     require("kulala").set_selected_env()
      --   end,
      --   ft = "http",
      --   desc = "[k]ulala select [e]nvironment",
      -- },
      {
        "<leader>kt",
        function()
          require("kulala").toggle_view()
        end,
        ft = "http",
        desc = "[k]ulala [t]oggle body/headers view",
      },
    },
  },
}
