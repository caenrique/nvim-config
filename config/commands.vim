autocmd BufRead,BufNewFile *.sbt set filetype=scala " Set scala as filetype when editing sbt files
autocmd Filetype json syntax match Comment +\/\/.\+$+ " Support json comments
autocmd BufWritePre * :call RemoveTrailingWhitespaces()

command! CloseHiddenBuffers call functions#CloseHiddenBuffers()
command! RenameFile call functions#RenameFile()
command! RemoveTrailingWhiteSpace call functions#RemoveTrailingWhitespaces()
