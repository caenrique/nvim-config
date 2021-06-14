local f = require("settings.functions")
local map = f.map

vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

map("i", "<C-Space>", "compe#complete()", { expr = true })
map("i", "<CR>", "compe#confirm()", { expr = true })
map("i", "<C-e>", "compe#close()", { expr = true })
map("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { expr = true })
map("i", "<C-f>", "compe#scroll({ 'delta': -4 })", { expr = true })
