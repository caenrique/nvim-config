fu! CloseNerdTreeAndSaveSession()
    execute 'tabdo NERDTreeClose'
    execute 'SessionSave'
endfunction

autocmd VimLeave * call CloseNerdTreeAndSaveSession()
