fu! CloseNerdTreeAndSaveSession()
    execute 'tabdo NERDTreeClose'
    execute 'SessionSave'
endfunction

autocmd VimLeavePre * if (g:session_loaded == 1) | call CloseNerdTreeAndSaveSession() | endif

