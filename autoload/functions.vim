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

function! functions#Repeat_with_visual_selection() range
  let [l:first_line, l:column] = getpos("'<")[1:2]
  let l:last_line = getpos("'>")[1]

  for l:line in range(l:first_line, l:last_line)
    exec "normal " . l:line . "G" . l:column . "|."
  endfor
endfunction

function! functions#swapBuffers(to)

  if type(a:to) == type(0)
    let l:destination_winid = win_getid(a:to)
  elseif a:to =~# '[hjlk]'
    let l:destination_winid = win_getid(winnr(a:to))
  else
    echo "argument must be a number or one of h j k l"
    return
  endif

  let l:current_window = win_getid()
  let l:current_buffer = bufnr()
  call win_gotoid(l:destination_winid)
  let l:other_buffer = bufnr()
  exec "b " . l:current_buffer
  call win_gotoid(l:current_window)
  exec "b " . l:other_buffer
  call win_gotoid(l:destination_winid)
endfunction

function! functions#search_and_replace(pattern, noconfirmation)
  let l:separator = a:pattern[0]
  let l:sp = split(a:pattern[1:], l:separator)

  if len(l:sp) == 2
    let l:grep = l:sp[0]
    let l:vim_search = l:sp[0]
    let l:replace = l:sp[1]
  else
    let l:grep = l:sp[0]
    let l:vim_search = l:sp[1]
    let l:replace = l:sp[2]
  endif

  silent execute("grep! " . l:grep) | copen | execute("cfdo %s/" . l:vim_search . "/" . l:replace . "/g" . (a:noconfirmation == '!' ? "" : "c")) | update | cclose
endfunction

function! functions#openNotesDir()
  if exists("g:notes_dir")
    execute "edit " . g:notes_dir . "/"
  endif
endfunction

function! functions#toggleDarkAndLightTheme()
  if g:lightOrDarkTheme == "dark"
    let g:lightOrDarkTheme = "light"
    colorscheme delek
    set background=light
    highlight CursorLine guibg=#f5f5f5
  else
    let g:lightOrDarkTheme = "dark"
    colorscheme onedark
    set background=dark
    highlight CursorLine guibg=#15161b
  endif
endfunction

function! functions#copy_search(pattern)
  let @c = ''
  execute "g/" . a:pattern . "/y C"
  let @+ = @c
endfunction
