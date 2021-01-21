nnoremap <Leader><space> :nohlsearch<CR>

" treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" Exit terminal easy
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
tnoremap <M-z> pwd\|pbcopy<CR><C-\><C-n>:cd <C-r>+<CR>i

nnoremap <silent> <leader>h :SwapBuffer('h')<CR>
nnoremap <silent> <leader>j :SwapBuffer('j')<CR>
nnoremap <silent> <leader>k :SwapBuffer('k')<CR>
nnoremap <silent> <leader>l :SwapBuffer('l')<CR>

" Tab navigation
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>

" Splits navigation
nnoremap gj <C-W>j
nnoremap gk <C-W>k
nnoremap gl <C-W>l
nnoremap gh <C-W>h

vnoremap . :'<,'>call functions#Repeat_with_visual_selection()<Enter>
