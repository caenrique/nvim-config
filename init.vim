if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
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

" Theme
runtime! config/onedark.vim

runtime! config/general-settings.vim

" Fuzzy search
runtime! config/fzf.vim

" Display git blame inline using virtual text
runtime! config/blamer.vim

" simple session management
runtime! config/autosession.vim

" File tree explorer
runtime! config/nerdtree.vim

" Status line
runtime! config/lightline.vim

" LSP pluggin
runtime! config/coc.vim

" Custom command and functions
runtime! config/commands.vim

" Custom keymappings
runtime! config/keymappings.vim
