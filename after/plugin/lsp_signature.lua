if not pcall(require, 'lsp_siganture') then
  return
end

require'lsp_signature'.setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  },
  -- hit_enable = false,
  -- always_trigger = true,
})
