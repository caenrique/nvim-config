autocmd FileType scala,python nnoremap <buffer> <silent> <C-Enter> :ReplSend<CR>
autocmd FileType scala,python vnoremap <buffer> <silent> <C-Enter> :'<,'>ReplSend<CR>
