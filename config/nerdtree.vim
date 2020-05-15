augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au FileType nerdtree setl signcolumn=no
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&filetype')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap FF :NERDTreeFind<Enter> <bar> <C-w>=
nnoremap ff :NERDTreeToggle<Enter> <bar> <C-w>=

let NERDTreeMinimalUI = 1
let NERDTreeWinSize=60
let NERDTreeMinimalMenu=1
let NERDTreeCascadeOpenSingleChildDir=1
let NERDTreeAutoDeleteBuffer=1
