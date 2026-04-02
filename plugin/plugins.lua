-- Plugin Hooks
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd.TSUpdate()
    end
  end,
})

-- Plugin sources
-- Configurations for plugins are in after/plugin/*
vim.pack.add({
  'gh:nvim-lua/plenary.nvim',
  'gh:folke/lazydev.nvim',
  'gh:MunifTanjim/nui.nvim',
  'gh:s1n7ax/nvim-window-picker',

  'gh:nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code

  -- Colorscheme
  { src = 'gh:catppuccin/nvim', name = 'catppuccin' },

  -- Git integration
  'gh:tpope/vim-fugitive', -- Git integration. Specifically I'm interested in the :G command
  'gh:NeogitOrg/neogit',
  { src = 'gh:fredrikaverpil/gitsigns.nvim', version = 'feat/toggle-inline-preview' },
  'gh:sindrets/diffview.nvim',

  -- LSP
  'gh:linrongbin16/lsp-progress.nvim', -- Display lsp progress messages in the statusline
  'gh:neovim/nvim-lspconfig', -- LSP Configurations
  'gh:williamboman/mason.nvim',
  'gh:WhoIsSethDaniel/mason-tool-installer.nvim',
  'gh:stevearc/conform.nvim', -- Auto-format
  'gh:scalameta/nvim-metals', -- Scala language server

  -- Auto-completion
  'gh:rafamadriz/friendly-snippets',
  'gh:xzbdmw/colorful-menu.nvim',
  'gh:ribru17/blink-cmp-spell',
  { src = 'gh:saghen/blink.cmp', version = vim.version.range('1.*') },

  -- File tree
  { src = 'gh:nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3.*') },

  -- Plugin collections (picker, statusline, icons, signcolumn, etc)
  'gh:folke/snacks.nvim', -- A collection of QoL plugins for Neovim
  'gh:echasnovski/mini.nvim', -- Collection of various small independent plugins/modules

  -- UI/UX
  'gh:mrjones2014/smart-splits.nvim',
  'gh:folke/which-key.nvim',

  -- Markdonw
  'gh:opdavies/toggle-checkbox.nvim',
})
