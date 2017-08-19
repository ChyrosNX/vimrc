" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'klen/python-mode'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" set fileformats=unix,dos
" set fileformat=unix

set backspace=indent,eol,start  " Make <BS> works as you would expect
set clipboard=unnamed           " Make copy-paste works as you would expect

set tabstop=4       " Number of spaces for <Tab>
set shiftwidth=4    " Number of spaces for << and >>
set expandtab       " Use spaces instead of a tab
set autoindent      " Copy indent to the next line
set smartindent     " Language-specific auto-indentation

set number  " Add line numbers
syntax on   " Enable syntax highlighting

set ignorecase  " Ignore-case searching
set hlsearch    " Enable search highlighting
set incsearch   " Enable incremental search

" Theme
" set background=light
" colorscheme darcula
" let g:airline_theme='dark theme'
let g:airline_theme='alduin'
" let g:airline_theme='angr'
" let g:airline_theme='aurora'
" let g:airline_theme='badcat'
" let g:airline_theme='badwolf'
" let g:airline_theme='base16'
" let g:airline_theme='base16color'
" let g:airline_theme='base16_3024'
" let g:airline_theme='base16_apathy'
" let g:airline_theme='base16_ashes'
" let g:airline_theme='base16_atelierdune'
" let g:airline_theme='base16_atelierforest'
" let g:airline_theme='base16_atelierheath'
" let g:airline_theme='base16_atelierlakeside'
" let g:airline_theme='base16_atelierseaside'
" let g:airline_theme='base16_bespin'
" let g:airline_theme='base16_brewer'
" let g:airline_theme='base16_bright'
" let g:airline_theme='base16_chalk'
" let g:airline_theme='base16_codeschool'
" let g:airline_theme='base16_colors'
" let g:airline_theme='base16_default'
" let g:airline_theme='base16_eighties'
" let g:airline_theme='base16_embers'
" let g:airline_theme='base16_flat'
" let g:airline_theme='base16_google'
" let g:airline_theme='base16_grayscale'
" let g:airline_theme='base16_greenscreen'
" let g:airline_theme='base16_harmonic16'
" let g:airline_theme='base16_hopscotch'
" let g:airline_theme='base16_isotope'
" let g:airline_theme='base16_londontube'
" let g:airline_theme='base16_marrakesh'
" let g:airline_theme='base16_mocha'
" let g:airline_theme='base16_monokai'
" let g:airline_theme='base16_ocean'
" let g:airline_theme='base16_oceanicnext'
" let g:airline_theme='base16_paraiso'
" let g:airline_theme='base16_pop'
" let g:airline_theme='base16_railscasts'
" let g:airline_theme='base16_seti'
" let g:airline_theme='base16_shapeshifter'
" let g:airline_theme='base16_shell'
" let g:airline_theme='base16_solarized'
" let g:airline_theme='base16_spacemacs'
" let g:airline_theme='base16_summerfruit'
" let g:airline_theme='base16_tomorrow'
" let g:airline_theme='base16_twilight'
" let g:airline_theme='behelit'
" let g:airline_theme='bubblegum'
" let g:airline_theme='cobalt2'
" let g:airline_theme='cool'
" let g:airline_theme='deus'
" let g:airline_theme='distinguished'
" let g:airline_theme='durant'
" let g:airline_theme='fairyfloss'
" let g:airline_theme='hybrid'
" let g:airline_theme='hybridline'
" let g:airline_theme='jellybeans'
" let g:airline_theme='kalisi'
" let g:airline_theme='kolor'
" let g:airline_theme='laederon'
" let g:airline_theme='light'
" let g:airline_theme='lucius'
" let g:airline_theme='luna'
" let g:airline_theme='minimalist'
" let g:airline_theme='molokai'
" let g:airline_theme='monochrome'
" let g:airline_theme='murmur'
" let g:airline_theme='onedark'
" let g:airline_theme='papercolor'
" let g:airline_theme='powerlineish'
" let g:airline_theme='qwq'
" let g:airline_theme='raven'
" let g:airline_theme='ravenpower'
" let g:airline_theme='serene'
" let g:airline_theme='sierra'
" let g:airline_theme='silver'
" let g:airline_theme='simple'
" let g:airline_theme='sol'
" let g:airline_theme='solarized'
" let g:airline_theme='term'
" let g:airline_theme='tomorrow'
" let g:airline_theme='ubaryd'
" let g:airline_theme='understated'
" let g:airline_theme='vice'
" let g:airline_theme='wombat'
" let g:airline_theme='xtermlight'
" let g:airline_theme='zenburn'
" 
let mapleader = ","

" python-mode Mappings
let g:pymode_rope_goto_definition_bind = "Alt+G"

" unmap Arrow Keys
map <up>    <nop> <abc>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>

" Alt+z Previous Tab
nmap ú      :tabp<CR>
imap ú <Esc>:tabp<CR>

" Alt+x Next Tab
nmap ø      :tabn<CR>
imap ø <Esc>:tabn<CR>

" Ctrl+N New Tab
nmap <C-N> :tabnew<CR>
imap <C-N> :tabnew<CR>

" Alt+C Close Tab
nmap ã :q<CR>

