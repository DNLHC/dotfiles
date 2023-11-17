syntax enable
set shiftwidth=2
set tabstop=2
set expandtab
set smartindent
set breakindent
set smartcase
set ignorecase
set nobackup
set noswapfile
set nowritebackup
set splitbelow
set splitright
set background=light
set backspace=indent,eol,start
set hidden
set hlsearch
set incsearch
set autoread

colorscheme default

let mapleader = "\<Space>"

nmap j gj
nmap k gk
nmap <C-j> 4j
xmap <C-j> 4j
nmap <C-k> 4k
xmap <C-k> 4k
nmap - $
xmap - $
nmap ; :
xmap ; :

nnoremap <leader>qq :q<CR>
nnoremap <leader>qQ :q!<CR>
cmap w!! w !sudo tee > /dev/null %

let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"

vnoremap <expr> cn g:mc . "``cgn"
nnoremap cn *``cgn

nnoremap gw *N
vnoremap gw *N
