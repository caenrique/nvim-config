if not pcall(require, 'diffview') then
  return
end

require('diffview').setup({
  view = {
    merge_tool = {
      layout = "diff3_mixed"
    }
  }
})
