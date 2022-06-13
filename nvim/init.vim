call plug#begin('~/.local/share/nvim/plugged')
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'machakann/vim-highlightedyank'
    Plug 'tpope/vim-rsi'
    Plug 'unblevable/quick-scope'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
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

function! IsWSL()
  if has('unix')
    let lines = readfile('/proc/version')
    if lines[0] =~ 'Microsoft'
      return 1
    endif
  endif
  return 0
endfunction

nmap j gj
nmap k gk
nmap <C-j> 4j
xmap <C-j> 4j
nmap <C-k> 4k
xmap <C-k> 4k
nmap - $
xmap - $
nnoremap ', '^
nnoremap x "_x

" provide hjkl movements in Command-line mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

set clipboard+=unnamedplus "yank to and paste the selection without prepending "*

" make clipboard work in WSL2
if IsWSL()
  let g:clipboard = {
            \   'name': 'win32yank-wsl',
            \   'copy': {
            \      '+': '/opt/win32yank.exe -i --crlf',
            \      '*': '/opt/win32yank.exe -i --crlf',
            \    },
            \   'paste': {
            \      '+': '/opt/win32yank.exe -o --lf',
            \      '*': '/opt/win32yank.exe -o --lf',
            \   },
            \   'cache_enabled': 0,
            \ }
endif

if !exists('g:vscode')

let mapleader = "\<Space>"

" Edit .vimrc
map <leader>vo :vsp $MYVIMRC<CR>
map <leader>vr :source $MYVIMRC<CR>

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
      \ '.yarn'
      \ ]

let g:NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer = 1

nmap <C-i> :NERDTreeToggle<CR>

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

function! s:vscodeGoToDefinition(str)
    if exists('b:vscode_controlled') && b:vscode_controlled
        call VSCodeNotify('editor.action.' . a:str)
    else
        " Allow to function in help files
        exe "normal! \<C-]>"
    endif
endfunction

nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

nnoremap gd <Cmd>call <SID>vscodeGoToDefinition('revealDefinition')<CR>
xnoremap gd <Cmd>call <SID>vscodeGoToDefinition('revealDefinition')<CR>

nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
xnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>

nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
xnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

nnoremap gs <Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>
xnoremap gs <Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>

" nnoremap gs <Cmd>call VSCodeNotify('workbench.action.goToSourceDefinition')<CR>
" xnoremap gs <Cmd>call VSCodeNotify('workbench.action.goToSourceDefinition')<CR>

nnoremap gt <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
xnoremap gt <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>

nnoremap gI <Cmd>call VSCodeNotify('references-view.findImplementations')<CR>
xnoremap gI <Cmd>call VSCodeNotify('references-view.findImplementations')<CR>

nnoremap gR <Cmd>call VSCodeNotify('references-view.findReferences')<CR>
xnoremap gR <Cmd>call VSCodeNotify('references-view.findReferences')<CR>

nnoremap gS <Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
xnoremap gS <Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>

nnoremap Gd <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
xnoremap Gd <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>

nnoremap Gh <Cmd>call VSCodeNotify('editor.showCallHierarchy')<CR>
xnoremap Gh <Cmd>call VSCodeNotify('editor.showCallHierarchy')<CR>

nnoremap Gi <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>
xnoremap Gi <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>

nnoremap Gr <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
xnoremap Gr <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>

nnoremap Gt <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>
xnoremap Gt <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>

nnoremap =w <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
nnoremap =W <Cmd>call VSCodeNotify('editor.action.formatDocument.multiple')<CR>

nnoremap =c <Cmd>call VSCodeNotify('editor.action.formatChanges')<CR>

nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>') })<CR>

highlight QuickScopePrimary guifg='#21a2c2' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#128b85' gui=underline ctermfg=81 cterm=underline

endif

