" Plugins (https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/nerdtree'
    Plug 'kien/ctrlp.vim'
    Plug 'klen/python-mode'
    Plug 'tpope/vim-surround'
    Plug 'majutsushi/tagbar'                " http://ctags.sourceforge.net/
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Experimental...
    Plug 'scrooloose/syntastic'
    Plug 'scrooloose/nerdcommenter'
    "Plug 'valloric/youcompleteme'
call plug#end()

" Plugin Settings
    let NERDTreeShowHidden=1
    let g:ctrlp_show_hidden=1                                   " Press F5 to clear cache
    let g:tagbar_ctags_bin='~/.vim/plugged/ctags58/ctags.exe'
    let g:airline_section_b='%{strftime("%c")}'
    let g:airline_section_y='BN: %{bufnr("%")}'
    let g:airline#extensions#tabline#enabled=1
    "let g:airline_left_sep='>'
    "let g:airline_right_sep='<'
    "let g:airline#extensions#tabline#left_sep='>'
    "let g:airline#extensions#tabline#right_sep='<'
" Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
" NERD Commenter
    filetype plugin on
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims=1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs=1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign='left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java=1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters={ 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines=1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace=1

" Themes
set guifont=Consolas:h11:cANSI:qDRAFT
set background=dark                     " light | dark
colorscheme solarized
let g:airline_theme='solarized'

" set fileformats=unix,dos
" set fileformat=unix
" set encoding=utf-8

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

let mapleader=","

" python-mode Mappings
let g:pymode_rope_goto_definition_bind="<A-g>"    " Alt+G -> Goto-definition

" Unmap Arrow Keys
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>

" Alt+1 NERDTreeToggle
nnoremap <A-1>      :NERDTreeToggle<CR>
inoremap <A-1> <Esc>:NERDTreeToggle<CR>

" Alt+2 TagbarToggle
nnoremap <A-2>      :TagbarToggle<CR>
inoremap <A-2> <Esc>:TagbarToggle<CR>

" Alt+x Next Tab
nnoremap <A-x>      :tabn<CR>
inoremap <A-x> <Esc>:tabn<CR>

" Alt+z Previous Tab
nnoremap <A-z>      :tabp<CR>
inoremap <A-z> <Esc>:tabp<CR>

" Ctrl+N New Tab
nnoremap <C-n>      :tabnew<CR>
inoremap <C-n> <Esc>:tabnew<CR>

" Alt+C Close Tab
nnoremap <A-c> :q<CR>

" Shift+Alt+C Close Other Tabs
nnoremap <A-C>      :tabonly<CR>
inoremap <A-C> <Esc>:tabonly<CR>

" Alt+Q Close Tab diregarding any changes!
nnoremap <A-q>      :q!<CR>
inoremap <A-q> <Esc>:q!<CR>

" Ctrl+K Next Change (diff)
nnoremap <C-k>      [c
inoremap <C-k> <Esc>[c

" Shift+Ctrl+K Previous Change (diff) - @TODO: doesn't work as expected
nnoremap <C-S-k>      ]c
inoremap <C-S-k> <Esc>]c

