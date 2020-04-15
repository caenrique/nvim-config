nnoremap <Leader><space> :nohlsearch<CR>

" treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" Exit terminal easy
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
tnoremap <M-z> pwd\|pbcopy<CR><C-\><C-n>:cd <C-r>+<CR>i

" Toggle terminal
nnoremap <silent> <C-z> :call nvim_toggle_terminal#ToggleTerminal()<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:call nvim_toggle_terminal#ToggleTerminal()<Enter>

" Tab navigation
nnoremap tj :tabfirst<CR>
nnoremap tk :tablast<CR>
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap tt :tabedit<Space>
nnoremap td :tabclose<CR>

" Splits navigation
nnoremap gj <C-W>j
nnoremap gk <C-W>k
nnoremap gl <C-W>l
nnoremap gh <C-W>h

" Alternative splits navegation
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Make the arrow keys usefull. Resize splits
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>

nnoremap <C-h> <C-w>H
nnoremap <C-l> <C-w>L
nnoremap <C-k> <C-w>K
nnoremap <C-j> <C-w>J
