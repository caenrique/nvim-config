map <Space> <Leader>

nnoremap <Leader><space> :nohlsearch<CR>

" treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" Tab navigation
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>

" Splits navigation
nnoremap gj <C-W>j
nnoremap gk <C-W>k
nnoremap gl <C-W>l
nnoremap gh <C-W>h

vnoremap . :'<,'>call functions#Repeat_with_visual_selection()<Enter>

nnoremap <C-p> "0p
vnoremap <C-p> "0p

nnoremap <Leader>g :Neogit<Enter>
