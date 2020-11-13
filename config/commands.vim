autocmd BufRead,BufNewFile *.sbt set filetype=scala " Set scala as filetype when editing sbt files
autocmd Filetype json syntax match Comment +\/\/.\+$+ " Support json comments
autocmd BufWritePre * :call functions#RemoveTrailingWhitespaces()
autocmd TermOpen * call nvim_toggle_terminal#TerminalOptions()

autocmd BufEnter * set cursorline
autocmd BufLeave * set nocursorline

command! CloseHiddenBuffers call functions#CloseHiddenBuffers()
command! RenameFile call functions#RenameFile()
command! RemoveTrailingWhiteSpace call functions#RemoveTrailingWhitespaces()
command! NotesDir call functions#openNotesDir()

command! -nargs=1 SwapBuffer call functions#swapBuffers(<args>)

command! Config tabnew | tcd ~/.config/nvim/ | e init.vim
command! -nargs=1 -complete=dir Tcd tabnew | tcd <args>

command! -nargs=1 -bang Replace call functions#search_and_replace("<args>", "<bang>")

function! FormatJsonFunction() range
  let command = a:firstline . "," . a:lastline . "!jq ."
  execute command
endfunction

command! -range FormatJson <line1>,<line2>call FormatJsonFunction()
