" nnoremap <Leader><space> :nohlsearch<CR>
" nnoremap <leader><tab> za
"
" " treat wrapped lines as normal lines
" nnoremap j gj
" nnoremap k gk
"
" " Tab navigation
" nnoremap th :tabprev<CR>
" nnoremap tl :tabnext<CR>
"
" " Splits navigation
" nnoremap gj <C-W>j
" nnoremap gk <C-W>k
" nnoremap gl <C-W>l
" nnoremap gh <C-W>h
"
" vnoremap . :'<,'>call functions#Repeat_with_visual_selection()<Enter>
"
" nnoremap <C-p> "0p
" vnoremap <C-p> "0p
"
"
" nnoremap n nzzzv
" nnoremap N Nzzzv
" nnoremap J mzJ`z
"
" vnoremap <C-j> :m '>+1<CR>gv
" vnoremap <C-k> :m '<-2<CR>gv
" inoremap <C-j> <esc>:m .+1<CR>i
" inoremap <C-k> <esc>:m .-2<CR>i
" "
" nnoremap <silent> <C-6> <C-^>
"
" autocmd FileType http nmap <buffer> <silent> <C-Enter> <Plug>RestNvim
" autocmd FileType http nmap <buffer> <silent> K <Plug>RestNvimPreview
"
" vnoremap * y:let @/ = @"<CR>
" vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
