call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'machakann/vim-highlightedyank'
    Plug 'tpope/vim-rsi'
  if !exists('g:vscode')
    Plug 'chriskempson/base16-vim'
    Plug 'tpope/vim-commentary'
    Plug 'flazz/vim-colorschemes'
    Plug 'pangloss/vim-javascript'
    Plug 'nanotech/jellybeans.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-sensible'
    Plug 'NLKNguyen/papercolor-theme'
    " Plug 'jlanzarotta/bufexplorer'
    Plug 'sonph/onehalf', {'rtp': 'vim/'}
    Plug 'posva/vim-vue'
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install()  } }
    " Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'haya14busa/incsearch.vim'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'elixir-lang/vim-elixir'
    Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass', 'html', 'eruby'] }
    Plug 'jiangmiao/auto-pairs'
    Plug 'valloric/MatchTagAlways'
    Plug 'vim-syntastic/syntastic'
    Plug 'mhinz/vim-signify' " VCS indicator
    Plug 'airblade/vim-gitgutter'
    Plug 'mattn/emmet-vim'
    Plug 'digitaltoad/vim-pug'
    Plug 'valloric/matchtagalways'
    Plug 'editorconfig/editorconfig-vim'
  endif
call plug#end()

nmap j gj
nmap k gk
nmap <C-j> 4j
nmap <C-k> 4k

set clipboard=unnamedplus "yank to and paste the selection without prepending "*

if !exists('g:vscode')
let mapleader = "\<Space>"

syntax enable
set termguicolors
set background=dark
colorscheme jellybeans
let g:airline_theme='jellybeans'

set ttyfast           " should make scrolling faster
set lazyredraw        " should make scrolling faster

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

set encoding=utf-8
set number
set hlsearch
set ignorecase
set smartcase
set nohlsearch
set hidden         "lets you switch buffers without saving

set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set nowb

set expandtab
set title
set softtabstop=2
set shiftwidth=2

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Edit .vimrc
map <leader>vo :vsp $MYVIMRC<CR>
map <leader>vr :source $MYVIMRC<CR>
" nmap <C-_> gcc

" nnoremap <leader>b :BufExplorer<CR>

" let g:bufExplorerDisableDefaultKeyMapping = 1
" let g:bufExplorerShowRelativePath = 1

" remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

let g:NERDTreeIgnore = [
      \ '\.vim$',
      \ '\.nvimlog',
      \ '\~$',
      \ '\.beam',
      \ 'deps',
      \ '.git',
      \ 'node_modules',
      \ 'bower_components',
      \ 'tags',
      \ ]

let g:NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer = 1

nmap <C-i> :NERDTreeToggle<CR>

" let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
" let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --ignore-file $HOME/.gitignore'
" let g:fzf_tags_command = 'ctags -R'
" let g:fzf_layout = {'up':'~50%', 'window': { 'width': 1, 'height': 0.5, 'yoffset':0, 'xoffset': 0 } }
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

" nnoremap <silent> <C-p> :Files<CR>
endif
if exists('g:vscode')
function! s:openWhichKeyInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>
endif
