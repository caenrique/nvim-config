augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.sbt set filetype=scala
  autocmd BufRead,BufNewFile *.sc set filetype=scala
  autocmd BufRead,BufNewFile *.hql set filetype=sql
augroup END

augroup utilities
  autocmd!
  autocmd BufWritePre * :call functions#RemoveTrailingWhitespaces()
  " autocmd TermOpen * call nvim_toggle_terminal#TerminalOptions()
  autocmd BufEnter * set cursorline
  autocmd BufLeave * set nocursorline
augroup END

command! CloseHiddenBuffers call functions#CloseHiddenBuffers()
command! RemoveTrailingWhiteSpace call functions#RemoveTrailingWhitespaces()

command! Config tabnew | tcd stdpath("config") | e init.lua

command! FoldOpenAll silent normal zR
command! FoldCloseAll silent normal zM
