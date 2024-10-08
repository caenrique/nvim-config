return {
  "dhruvasagar/vim-table-mode",
  "almo7aya/openingh.nvim",
  -- 'alvarosevilla95/luatab.nvim',
  "kevinhwang91/nvim-bqf",
  "ckipp01/stylua-nvim",
  "neovim/nvim-lspconfig",
  "nvim-lua/plenary.nvim",
  -- 'richardbizik/nvim-toc',
  "artemave/workspace-diagnostics.nvim",
  -- { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
  { "windwp/nvim-autopairs", config = true },
  { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lua",
      "petertriho/cmp-git",
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = false,
        show_exact_scope = true,
        highlight = { "Function", "Label" },
        priority = 500,
        include = {
          node_type = {
            scala = { "for_expression", "match_expression", "case_clause" },
          },
        },
      },
      exclude = {
        filetypes = {
          "dashboard",
        },
      },
    },
  },
}
