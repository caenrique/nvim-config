function! functions#CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction

function! functions#RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! functions#RemoveTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  keepp %s/\s\+$//e
  call cursor(l, c)
endfunction

function! functions#ToggleOnly()
  if winnr("$") > 1
    let l:origin = {
      \ 'tabNumber' : tabpagenr(),
      \ 'windowNumber' : winnr()
    \}
    tab sp
    let w:origin = l:origin
  elseif exists("w:origin") && index(tabpagebuflist(w:origin.tabNumber), bufnr()) >= 0
    let l:originTabNumber = (w:origin.tabNumber < tabpagenr()) ? w:origin.tabNumber : w:origin.tabNumber - 1
    let l:originWindowNumber = w:origin.windowNumber
    tabclose
    exec l:originTabNumber . "tabnext"
    exec l:originWindowNumber . "wincmd w"
  else
    return 0
  endif
endfunction
