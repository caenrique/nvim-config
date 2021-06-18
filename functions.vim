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

function! functions#Repeat_with_visual_selection() range
  let [l:first_line, l:column] = getpos("'<")[1:2]
  let l:last_line = getpos("'>")[1]

  for l:line in range(l:first_line, l:last_line)
    exec "normal " . l:line . "G" . l:column . "|."
  endfor
endfunction

function! functions#FormatJsonFunction() range
  let command = a:firstline . "," . a:lastline . "!jq ."
  execute command
endfunction

