autocmd BufRead,BufNewFile *.sbt set filetype=scala
autocmd BufRead,BufNewFile *.sc set filetype=scala
autocmd BufRead,BufNewFile *.conf set filetype=json
autocmd BufRead,BufNewFile *.avsc set filetype=json
autocmd Filetype json syntax match Comment +\/\/.\+$+ " Support json comments
autocmd BufWritePre * :call functions#RemoveTrailingWhitespaces()
autocmd TermOpen * call nvim_toggle_terminal#TerminalOptions()
autocmd BufWritePre *.scala,*.sbt,*.sc lua vim.lsp.buf.formatting_sync(nil, 1000)

autocmd BufEnter * set cursorline
autocmd BufLeave * set nocursorline

command! CloseHiddenBuffers call functions#CloseHiddenBuffers()
command! RemoveTrailingWhiteSpace call functions#RemoveTrailingWhitespaces()

command! Config tabnew | tcd ~/.config/nvim/ | e init.vim

command! -range FormatJson <line1>,<line2>call functions#FormatJsonFunction()

command! -nargs=1 Browse silent execute "!git web--browse " string(<q-args>)
