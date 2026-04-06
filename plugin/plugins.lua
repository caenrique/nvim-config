vim.pack.add({

  -- Common plugin dependencies
  'gh:nvim-lua/plenary.nvim', -- All the lua functions I don't want to write twice.
  'gh:folke/lazydev.nvim', -- Faster LuaLS setup for Neovim.
  'gh:MunifTanjim/nui.nvim', -- UI Component Library for Neovim.
  'gh:s1n7ax/nvim-window-picker', -- Window picker promt.
  'gh:nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code.

  -- Colorscheme
  { src = 'gh:catppuccin/nvim', name = 'catppuccin' },

  -- Git integration
  'gh:tpope/vim-fugitive', -- Git integration. Specifically I'm interested in the :G command.
  'gh:NeogitOrg/neogit', -- An interactive and powerful Git interface for Neovim, inspired by Magit.
  'gh:fredrikaverpil/gitsigns.nvim', -- Git integration for buffers.
  'gh:esmuellert/codediff.nvim', -- VSCode-style diff rendering.

  -- LSP
  'gh:linrongbin16/lsp-progress.nvim', -- Display lsp progress messages in the statusline.
  'gh:neovim/nvim-lspconfig', -- LSP Configurations.
  'gh:williamboman/mason.nvim', -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  'gh:WhoIsSethDaniel/mason-tool-installer.nvim', -- Install and upgrade third party tools automatically.
  'gh:stevearc/conform.nvim', -- Auto-format.
  'gh:scalameta/nvim-metals', -- Scala language server.

  -- Auto-completion
  'gh:rafamadriz/friendly-snippets', -- Set of preconfigured snippets for different languages.
  'gh:xzbdmw/colorful-menu.nvim', -- Treesitter highlighting in completion menu.
  'gh:ribru17/blink-cmp-spell', -- Spell source for blink.cmp.
  { src = 'gh:saghen/blink.cmp', version = vim.version.range('1.*') }, -- Performant, batteries-included completion plugin for Neovim.

  -- File tree
  { src = 'gh:nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3.*') }, -- Neovim plugin to manage the file system and other tree like structures.

  -- Plugin collections (picker, statusline, icons, etc)
  'gh:folke/snacks.nvim', -- A collection of QoL plugins for Neovim.
  'gh:echasnovski/mini.nvim', -- Collection of various small independent plugins/modules.

  -- UI/UX
  'gh:mrjones2014/smart-splits.nvim', -- Directional navigation and resizing of Neovim + terminal multiplexer splits.
  'gh:folke/which-key.nvim', -- Available keybindings in a popup as you type.
  "gh:j-hui/fidget.nvim", -- UI for Neovim notifications and LSP progress messages.

  -- Markdown
  'gh:opdavies/toggle-checkbox.nvim', -- Toggling Markdown checkboxes.

  -- Quickfix
  'gh:kevinhwang91/nvim-bqf', -- Better quickfix window in Neovim.
  'gh:yorickpeterse/nvim-pqf', -- Prettier quickfix/location list windows for NeoVim.
})

require('bqf').setup()
require('pqf').setup({ max_filename_length = 100, })

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
