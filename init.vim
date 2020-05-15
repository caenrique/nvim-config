if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'itchyny/lightline.vim' " Status bar
Plug 'joshdick/onedark.vim' " Color theme
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP client
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'} " Scala LSP server
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy find
Plug 'junegunn/fzf.vim' " Integration with fzf
Plug 'scrooloose/nerdtree' " File tree explorer
Plug 'albfan/nerdtree-git-plugin' " Git integration with nerdtree
Plug 'DevWurm/autosession.vim' " Load vim sessions automaticaly
Plug 'sheerun/vim-polyglot' " Syntax higlighting support for multiple languages
Plug 'tpope/vim-fugitive' " Git commands in vim
Plug 'airblade/vim-gitgutter' " Git status symbols in gutter
Plug 'APZelos/blamer.nvim' " Display git blame information inline with virtual text
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " Open a rendered view in the browser
Plug 'dhruvasagar/vim-table-mode' " Better support for editing markdown tables
Plug 'machakann/vim-sandwich' " Add/remove/change enclosing characters arround things
Plug 'tpope/vim-commentary' " Comment code easier
Plug 'caenrique/nvim-toggle-terminal' " Better configs for terminal buffer
Plug 'caenrique/nvim-maximize-window-toggle' " Maximaze window command
Plug 'will-ockmore/vim-notes' " Simple note taking workflow
Plug 'gcmt/taboo.vim' " Rename tabs
Plug 'simnalamburt/vim-mundo' " Display undo tree
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
set undofile
set undodir=$HOME/.config/nvim/history

map <Space> <Leader>

if executable('ag')
  set grepprg=ag\ --nogroup
endif

runtime! config/*.vim
