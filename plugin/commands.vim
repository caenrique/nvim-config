augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.sbt set filetype=scala
  autocmd BufRead,BufNewFile *.sc set filetype=scala
  autocmd BufRead,BufNewFile *.hql set filetype=sql
  " autocmd BufRead,BufNewFile *.conf set filetype=json
  " autocmd BufRead,BufNewFile *.avsc set filetype=json
augroup END

augroup utilities
  autocmd!
  autocmd BufWritePre * :call functions#RemoveTrailingWhitespaces()
  autocmd TermOpen * call nvim_toggle_terminal#TerminalOptions()
  autocmd BufEnter * set cursorline
  autocmd BufLeave * set nocursorline
augroup END

augroup markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md set tabstop=4
  autocmd BufRead,BufNewFile *.md set shiftwidth=4
augroup END

command! CloseHiddenBuffers call functions#CloseHiddenBuffers()
command! RemoveTrailingWhiteSpace call functions#RemoveTrailingWhitespaces()

command! Config tabnew | tcd ~/.config/nvim/ | e init.lua

command! -range FormatJson <line1>,<line2>call functions#FormatJsonFunction()

command! -nargs=1 Browse silent execute "!git web--browse " string(<q-args>)

command! FoldOpenAll silent normal zR
command! FoldCloseAll silent normal zM
