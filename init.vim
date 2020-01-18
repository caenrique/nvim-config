if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/albfan/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'DevWurm/autosession.vim'
Plug 'machakann/vim-sandwich'
Plug 'APZelos/blamer.nvim'
call plug#end()

runtime! config/fzf.vim
runtime! config/blamer.vim
runtime! config/onedark.vim
runtime! config/commands.vim
runtime! config/general-settings.vim
runtime! config/keymappings.vim
runtime! config/autosession.vim
runtime! config/nerdtree.vim
runtime! config/lightline.vim
runtime! config/coc.vim

" Don't know why this doesn't work 
" for fpath in split(globpath('~/.config/nvim/config', '*.vim'), '\n')
" 	echo fpath
"    runtime fpath
" endfor
