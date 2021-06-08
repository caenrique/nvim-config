fu! CloseNerdTreeAndSaveSession()
    execute 'tabdo NERDTreeClose'
    execute 'SessionSave'
endfunction

autocmd VimEnter * if (filereadable('.session.vim')) | let g:session_loaded = 1 | endif
autocmd VimLeave * if (exists("g:session_loaded") && g:session_loaded == 1) | call CloseNerdTreeAndSaveSession() | endif

command! Save call CloseNerdTreeAndSaveSession()
