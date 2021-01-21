nnoremap <Leader>f :Files!<CR>
nnoremap <Leader>a :Ag!<CR>
nnoremap <Leader>b :Buffers!<CR>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_buffers_jump = 1
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']
