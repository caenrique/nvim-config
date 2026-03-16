-- function replacePackageNames(path)
--   local label1 = string.gsub(path, 'src/main/scala/com/siriusxm/playbackservices', '#playbackservices')
--   local label2 = string.gsub(label1, 'src/main/scala/com/siriusxm/playback', '#playback')
--   local label3 = string.gsub(label2, 'main/scala/com/siriusxm/playbackservices', '#playbackservices')
--   local label4 = string.gsub(label3, 'main/scala/com/siriusxm/playback', '#playback')
--
--   local label = label4
--   -- split on #
--   -- split on last /
--   -- replace all / with .
--   -- put together before_# / with_dots / last
--   for module, rest in string.gmatch(label4, '(.+)#(.+)') do
--     local last = string.match(rest, '.+(/[^/]+)$')
--     local first = string.match(rest, '(.+)/[^/]+$')
--     label = module .. string.gsub(first, '/', '.') .. last
--   end
--
--   return label
-- end

function _G.TabLineLabel(index)
  local buflist = vim.fn.tabpagebuflist(index)
  local winnr = vim.fn.tabpagewinnr(index)
  local bufname = vim.fn.bufname(buflist[winnr])
  local label = '[No Name]'

  if bufname ~= '' then
    label = vim.fs.basename(bufname)
  end

  return index .. ': ' .. label
end

function _G.TabLine()
  local tab_line_string = ''
  for tab_index = 1, vim.fn.tabpagenr('$') do
    if tab_index == vim.fn.tabpagenr() then -- it is the current tab
      tab_line_string = tab_line_string .. '%#TabLineSel#' -- Current tab hightlighting
    else
      tab_line_string = tab_line_string .. '%#TabLine#' -- Inactive tab hightlighting
    end

    tab_line_string = tab_line_string .. '%' .. tab_index .. 'T' -- Tab index to make clicks work
    tab_line_string = tab_line_string .. ' %{v:lua.TabLineLabel(' .. tab_index .. ')} ' -- tab label
  end
  tab_line_string = tab_line_string .. '%#TabLineFill#%T' -- Empty space

  if vim.fn.tabpagenr('$') > 1 then
    tab_line_string = tab_line_string .. '%=%#TabLine#%999Xclose' -- Close button
  end

  return tab_line_string
end

vim.o.tabline = '%!v:lua.TabLine()'
