    " Início da configuração dos plugins
call plug#begin('~/.vim/plugged')

" Lista de plugins em ordem alfabética
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'terroo/vim-simple-emoji'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim/colorschemes'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'

call plug#end()

" Configurações globais
set ai
syntax on
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set hidden
set incsearch
set ignorecase
set smartcase
set scrolloff=8
set signcolumn=yes
set cmdheight=2
set updatetime=100
set encoding=utf-8
set nobackup
set nowritebackup
set splitright
set splitbelow
set autoread
set mouse=a
set history=5000
set number
set cursorline
set autoindent
set clipboard=unnamedplus
set foldmethod=syntax
filetype on
filetype plugin on
filetype indent on

" Mapeamentos de teclas
nmap <C-z> :u<CR>
nmap <C-s> :w<CR>
nmap <C-c> :yy<CR>
nmap <C-v> :p<CR>

" Atalhos para navegação entre splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Atalhos personalizados
nmap te :tabe<CR>
nmap td :bd<CR>
nmap th :split<CR>
nmap tv :vsplit<CR>
nmap tt :q<CR>
nmap tc :!

" Destacar a palavra sob o cursor
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction
autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" Configuração do AirLine
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Configuração de temas
set termguicolors
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
colorscheme gruvbox
set background=dark
let g:lightline = {'colorscheme': 'gruvbox'}
let g:airline_theme = "gruvbox"

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰ '
let g:airline_symbols.maxlinenr = '  '
let g:airline_symbols.dirty='⚡'

set foldlevel=99
nnoremap <space> za

let g:indentLine_enabled = 1
map <c-k>i :IndentLinesToggle<cr>
map <C-b> :NERDTreeToggle<cr>

set encoding=utf8
set laststatus=2
let g:airline_statusline_ontop=0

" Navegação entre buffers
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>
nnoremap <C-x> :bp \| bd<CR>

let g:ctrlp_custom_ignore = '\v[\/]\.(swp|zip)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_show_hidden = 1

" Configuração do NerdCommenter
let g:NERDSpaceDelims = 1
map cc <Plug>NERDCommenterInvert

" Configuração do ALE
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint'],
\   'cpp': [],
\   'c': []
\}

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'cpp': ['clang-format'],
\   'c': ['clang-format'],
\}

let g:ale_fix_on_save = 1
nmap <F10> :ALEFix<CR>

" Configuração do COC
let g:coc_global_extensions = [ 'coc-snippets', 'coc-explorer', 'coc-clangd' ]

" Atalhos para snippets do COC
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
xmap <leader>x  <Plug>(coc-convert-snippet)

" C/C++
let g:ale_c_clangformat_options = '"-style={
\ BasedOnStyle: google,
\ IndentWidth: 4,
\ ColumnLimit: 100,
\ AllowShortBlocksOnASingleLine: Always,
\ AllowShortFunctionsOnASingleLine: Inline,
\ FixNamespaceComments: true,
\ ReflowComments: false,
\ }"'

" Correção do erro no TAB do COC
function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
       \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

