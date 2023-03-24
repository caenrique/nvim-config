nnoremap <buffer> <silent> dd
  \ <Cmd>call setqflist(filter(getqflist(), {idx -> idx != line('.') - 1}), 'r')<CR>

nnoremap <buffer> <silent> q <cmd>q<CR>

setlocal winbar=Quickfix\ List
