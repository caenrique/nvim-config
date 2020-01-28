nnoremap <Leader><space> :nohlsearch<CR>

" treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" Tab navigation
nnoremap tj :tabfirst<CR>
nnoremap tk :tablast<CR>
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap tt :tabedit<Space>
nnoremap td :tabclose<CR>

" Splits navigation using Ctrl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Use <option> to Move the view, not the cursor
map <M-j> <C-e>
map <M-k> <C-y>
