if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'gmarik/Vundle.vim'
Plug 'mileszs/ack.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'rhysd/vim-crystal'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'zah/nim.vim'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }
Plug 'ryanoasis/vim-devicons'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

runtime macros/matchit.vim

set autoindent
set cpo+=$ " $ show string after c
set foldlevelstart=99
set foldmethod=indent
set hidden " allow unsaved buffers in background
set hlsearch
set ignorecase " ignore case
set laststatus=2 " Always display status line
set modelines=0 " no modelines
set nojoinspaces " no whitespace after join
set number " show line numbers
set ruler " show line and column numbers of the cursor
set showcmd " show command in statusline
set showmatch " show matching brackets
set showmode " show current mode
set smartcase " search with smart case
set smartindent
set splitbelow
set splitright
set visualbell " blink
set wildmenu " use wildmenu in commandline
set scrolloff=3
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l
set nobackup
set nowritebackup
set noswapfile
set ttimeoutlen=50

if has('mouse')
  set mouse=a
endif

let mapleader = ","

augroup vimrc
  autocmd!
  autocmd FileType ruby,haml,html,eruby,yaml,sass,css,javascript,cucumber,vim,elixir,crystal
        \ setlocal shiftwidth=2 |
        \ setlocal tabstop=2 |
        \ setlocal expandtab
  autocmd FileType ruby,haml,html,eruby,yaml,sass,css,javascript,cucumber,vim,cpp,elixir,crystal
        \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup end

" Whitespace highlighting
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red


" Colorscheme
let g:gruvbox_italic='1'
let g:gruvbox_contrast_dark='hard'
set background=dark
set termguicolors
colorscheme gruvbox


" Don't use Ex mode, use Q for formatting
noremap Q gq

" Use <leader>o to jump to implementation
nnoremap <leader>o <c-]>

nnoremap <CR> :nohlsearch<CR><CR>

execute "set colorcolumn=" . join(range(81,335), ',')

" Disable cursor keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Edit and source vimrc
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

" NERDTree
nnoremap <silent> <c-n> :NERDTreeToggle<CR>

" Airline
let g:airline_powerline_fonts = 1
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_theme='gruvbox'

" vim-test
nnoremap <silent> <leader>s :TestNearest<CR>
nnoremap <silent> <leader>c :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>

" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_map = '<Leader>p'
nnoremap <silent> <leader>t :CtrlPTag<cr>

" ack
let g:ack_use_cword_for_empty_search = 1

if executable('rg')
  " use ripgrep for ack
  let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

  " use ripgrep for ctrlp
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" deoplete
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

" lsp
let g:LanguageClient_serverCommands = {
\   'nim': ['~/.nimble/bin/nimlsp'],
\   'javascript': ['typescript-language-server', '--stdio'],
\   'typescript': ['typescript-language-server', '--stdio'],
\ }
nmap <F5> <Plug>(lcn-menu)
let g:LanguageClient_diagnosticsDisplay={
  \       '1': {
  \           'name': 'Error',
  \           'texthl': '',
  \           'signText': '✖',
  \           'signTexthl': 'ALEErrorSign',
  \       },
  \       '2': {
  \           'name': 'Warning',
  \           'texthl': '',
  \           'signText': '⚠',
  \           'signTexthl': 'ALEWarningSign',
  \       },
  \       '3': {
  \           'name': 'Information',
  \           'texthl': '',
  \           'signText': 'ℹ',
  \           'signTexthl': 'ALEInfoSign',
  \       },
  \       '4': {
  \           'name': 'Hint',
  \           'texthl': '',
  \           'signText': '➤',
  \           'signTexthl': 'ALEInfoSign',
  \       },
  \  }

" debug stuff
" let g:LanguageClient_loggingLevel = 'INFO'
" let g:LanguageClient_virtualTextPrefix = ''
" let g:LanguageClient_loggingFile =  expand('~/LanguageClient.log')
" let g:LanguageClient_serverStderr = expand('~/LanguageServer.log')


" functions
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
