function! functions#CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete! ".num
    endif
  endfor
endfunction

function! functions#RemoveTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  keepp %s/\s\+$//e
  call cursor(l, c)
endfunction
