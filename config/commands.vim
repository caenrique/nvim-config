" Set scala as filetype when editing sbt files
au BufRead,BufNewFile *.sbt set filetype=scala

" Support json comments
autocmd Filetype json syntax match Comment +\/\/.\+$+

command! CloseHiddenBuffers call s:CloseHiddenBuffers()

function! s:CloseHiddenBuffers()
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

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

command! RenameFile call RenameFile()

fun! RemoveTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun

command! RemoveTrailingWhiteSpace call RemoveTrailingWhitespaces()

au BufWritePre * :call RemoveTrailingWhitespaces()
