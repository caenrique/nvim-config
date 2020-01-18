if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'

" File navigations
Plug 'scrooloose/nerdtree'
Plug 'albfan/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Sessions
Plug 'DevWurm/autosession.vim'

" Interface
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'

" Syntax
Plug 'machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'

call plug#end()

runtime! config/onedark.vim
runtime! config/general-settings.vim
runtime! config/commands.vim
runtime! config/keymappings.vim
runtime! config/fzf.vim
runtime! config/blamer.vim
runtime! config/autosession.vim
runtime! config/nerdtree.vim
runtime! config/lightline.vim
runtime! config/coc.vim

" Don't know why this doesn't work 
" for fpath in split(globpath('~/.config/nvim/config', '*.vim'), '\n')
" 	echo fpath
"    runtime fpath
" endfor
