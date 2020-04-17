call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
Plug 'sheerun/vim-polyglot'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'scrooloose/nerdtree'
Plug 'albfan/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'DevWurm/autosession.vim'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'dhruvasagar/vim-table-mode'
Plug 'caenrique/nvim-toggle-terminal'
Plug 'caenrique/nvim-maximize-window-toggle'
call plug#end()

set autowrite
set autowriteall
set nobackup
set nowritebackup
set noswapfile
set noshowmode
set splitright
set splitbelow
set inccommand=split
set clipboard=unnamed
set mouse=a
set number
set lazyredraw
set linebreak
set ignorecase
set smartcase
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set shiftround
set list
set conceallevel=0

map <Space> <Leader>

runtime! config/*.vim
