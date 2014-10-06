" Vundle stuff
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'
" bundles
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'mileszs/ack.vim'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-bundler'
Bundle 'thoughtbot/vim-rspec'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-commentary'

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
set foldmethod=syntax "Fold anhand der Syntax
set foldlevelstart=99 "Default nicht folden

" Einrückungszeug
set autoindent
set smartindent
set shiftwidth=2
set expandtab
set tabstop=2

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

"Whitespace handling
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

filetype plugin indent on
syntax enable

" Colorscheme laden
colorscheme jellybeans

let mapleader = ","

" Tastaturmappings
"
" für NERDTree
nmap <silent> <c-n> :NERDTreeToggle<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

set ttimeoutlen=50

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ %l/%L:%c:%P\ \ %y\ \ %{fugitive#statusline()}

" Disable cursor keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" for vim-rspec
map <Leader>c :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

execute "set colorcolumn=" . join(range(81,335), ',')

" hidden files in ctrlp
let g:ctrlp_show_hidden = 1

let g:ctrlp_map = '<Leader>p'

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" use ag for ack
let g:ackprg = 'ag --nogroup --nocolor --column'
