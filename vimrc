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
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'rhysd/vim-crystal'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'zah/nim.vim'
Plug 'tpope/vim-endwise'
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

call plug#end()

runtime macros/matchit.vim

set showmode " z.B. Insertmode anzeigen
set showmatch " z.B. zugehörige Klammen zeigen
set showcmd " getipptes Kommando unten rechts anzeigen
" set ruler " Zeilennummen unten rechts anzeigen
set nojoinspaces " Keine Leerzeichen beim joinen
set cpo+=$ " $ am Ende des mit c zu ersetzenden Teils anzeigen
set modelines=0 " keine Modelines aufführen
set hidden " ungespeicherte Buffer im Hintergrund erlauben
set ignorecase " caseinsensitiv suchen
set smartcase " bei Großschreibung casesensitiv suchen
set visualbell " blinken statt geräusche
set t_vb= " auch nicht blinken
set wildmenu " menu für commandlinecompletion
set nu " Zeilennummern anzeigen
set laststatus=2 " Statuszeile immer zeigen
set foldmethod=indent
set foldlevelstart=99 "Default nicht folden
set autoindent
set smartindent
set splitright
set splitbelow
set hlsearch

augroup vimrc
  autocmd!
  autocmd FileType ruby,haml,html,eruby,yaml,sass,css,javascript,cucumber,vim,elixir,crystal
        \ setlocal shiftwidth=2 |
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2 |
        \ setlocal expandtab
  autocmd FileType ruby,haml,html,eruby,yaml,sass,css,javascript,cucumber,vim,cpp,elixir,crystal
        \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup end

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" no backups, no swapfiles
set nobackup
set nowritebackup
set noswapfile
" tell vim to keep a backup file
" set backup
" tell vim where to put its backup files
" set backupdir=~/.vim_tmp
" tell vim where to put swap files
" set dir=~/.vim_tmp

"Whitespace highlighting
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Colorscheme laden
colorscheme jellybeans

let mapleader = ","

" Tastaturmappings
"
" für NERDTree
nnoremap <silent> <c-n> :NERDTreeToggle<CR>

" Don't use Ex mode, use Q for formatting
noremap Q gq

" Use <leader>o to jump to implementation
nnoremap <leader>o <c-]>

nnoremap <CR> :nohlsearch<CR><CR>

set ttimeoutlen=50

" Format the statusline
" set statusline=\ %F%m%r%h\ %w\ %l/%L:%c:%P\ \ %y\ \ %{fugitive#statusline()}
" Confgure airline
let g:airline_powerline_fonts = 1
if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

" Disable cursor keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

nnoremap <silent> <leader>s :TestNearest<CR>
nnoremap <silent> <leader>c :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>

nnoremap <silent> <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

execute "set colorcolumn=" . join(range(81,335), ',')

" hidden files in ctrlp
let g:ctrlp_show_hidden = 1

let g:ctrlp_map = '<Leader>p'
nnoremap <silent> <leader>t :CtrlPTag<cr>

if executable('rg')
  " use ripgrep for ack
  let g:ackprg = 'rg --vimgrep --no-heading'

  " use ripgrep for ctrlp
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" functions
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
