function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:go_to_definition_in_new_tab()
  if get(t:, 'is_go_to_definition_tab')
    call CocAction('jumpDefinition')
  else
    let l:winid = win_getid()
    call CocAction('jumpDefinition', 'tab drop')
    if win_getid() != l:winid
      let t:is_go_to_definition_tab = 1
    endif
    execute "nnoremap <silent><buffer> <C-O> :bd \\| :call win_gotoid(" . l:winid . ")<CR>"
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>e :<C-u>CocList --auto-preview diagnostics<CR>
nmap <leader>r  <Plug>(coc-rename)
nmap <leader>F  <Plug>(coc-format-selected)
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <leader>n :call CocAction('runCommand', 'metals.new-scala-file')<Enter>
nnoremap <leader>s :call CocAction('runCommand', 'metals.go-to-super-method')<CR>
nnoremap <silent> <leader>c :<C-u>CocList commands<cr>
nmap <silent> gd :call <SID>go_to_definition_in_new_tab()<CR>
nmap <silent> gD :call CocAction('jumpDefinition')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
vmap <C-space>  <Plug>(coc-codeaction-selected)<CR>
nmap <C-space>  <Plug>(coc-codeaction-selected)<CR>
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

autocmd CursorHold * silent call CocActionAsync('highlight') " Highlight symbol under cursor on CursorHold
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

augroup mygroup
  autocmd!
  autocmd FileType scala setl formatexpr=CocAction('formatSelected') " Setup formatexpr specified filetype(s).
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp') " Update signature help on jump placeholder
augroup end

set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give ins-completion-menu messages.
set signcolumn=yes " always show signcolumns
let g:coc_global_extensions = ['coc-pairs']
