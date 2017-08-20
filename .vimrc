set nocompatible    " Use vim settings instead of vi
set encoding=utf-8

""" Plugins (https://github.com/junegunn/vim-plug)
call plug#begin("~/.vim/plugged")
    Plug 'altercation/vim-colors-solarized' " General theme
    Plug 'vim-airline/vim-airline'          " Status and Tab line
    Plug 'vim-airline/vim-airline-themes'   " vim-airline theme
    Plug 'scrooloose/nerdtree'              " File system explorer
    Plug 'kien/ctrlp.vim'                   " Fuzzy file search, mru, etc..
    Plug 'tpope/vim-fugitive'               " Git integration
    Plug 'airblade/vim-gitgutter'           " Git diff signs
    Plug 'tpope/vim-surround'               " Surround text w/ (), {}, etc..
    Plug 'scrooloose/nerdcommenter'         " Comment functions
    Plug 'scrooloose/syntastic'             " Syntax-checking
    Plug 'majutsushi/tagbar'                " Class outline viewer
    Plug 'klen/python-mode'                 " Python plug-in
call plug#end()

""" Plugin Settings
filetype plugin on                          " Req'd for NERDCommenter
let g:airline#extensions#tabline#enabled=1  " Show Tab line
let NERDTreeShowHidden=1                    " Show hidden files in NERDTree
let g:ctrlp_show_hidden=1                   " Show hidden files in CtrlP
""" Tagbar - ctags path (DL: http://ctags.sourceforge.net/)
let g:tagbar_ctags_bin="~/.vim/plugged/ctags58/ctags.exe"
""" python-mode...
let g:pymode_rope=0             " Disabled due to slow-caching issue
"let g:pymode_python="python3"  " python2 | python3
""" Syntastic...
set statusline+=%#warningmsg#               " Last given warning message
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1  " Fill loc-list with errors
let g:syntastic_auto_loc_list=1             " Open loc-list on errors
let g:syntastic_check_on_open=1             " Run syntax checks on open
let g:syntastic_check_on_wq=0               " Skips check on close
" NERDCommenter...
let g:NERDSpaceDelims=1             " Space after comment delimiter
let g:NERDDefaultAlign="left"       " Align when inserting a comment
let g:NERDCustomDelimiters={
    \    "c"     : { "left": "/**","right": "*/" }
    \    , "java": { "left": "/**","right": "*/" }
    \}
let g:NERDCommentEmptyLines=1       " Include empty lines when commenting
let g:NERDTrimTrailingWhitespace=1  " Uncommenting removes trailing spaces

" Font & Themes (GVIM only)
if has("gui_running")
    set background=dark                 " light | dark
    colorscheme solarized
    let g:airline_theme="solarized"
endif
let g:nx_font_size="normal"             " small | normal | large | xlarge
let g:nx_font_unix="Monospace Regular"
let g:nx_font_dos="Consolas"
let g:nx_font_mac="Monaco"
 
set backspace=indent,eol,start  " Make <BS> works as you would expect
set clipboard=unnamed           " Make copy-paste works as you would expect

set tabstop=4                   " Number of spaces for <Tab>
set shiftwidth=4                " Number of spaces for << and >>
set expandtab                   " Use spaces instead of a tab
set autoindent                  " Copy indent to the next line
set smartindent                 " Language-specific auto-indentation

set number                      " Add line numbers
syntax on                       " Enable syntax highlighting

set ignorecase                  " Ignore-case searching
set hlsearch                    " Enable search highlighting
set incsearch                   " Enable incremental search

let mapleader=","

""" python-mode Mappings
let g:pymode_rope_goto_definition_bind="<A-g>"  " Alt+G -> Goto-definition

""" Unmap Arrow Keys
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>

""" Alt+1 NERDTreeToggle
nnoremap <A-1>      :NERDTreeToggle<CR>
inoremap <A-1> <Esc>:NERDTreeToggle<CR>

""" Alt+2 TagbarToggle
nnoremap <A-2>      :TagbarToggle<CR>
inoremap <A-2> <Esc>:TagbarToggle<CR>

""" Alt+[X|Z] Next/Prev Tab
nnoremap <A-x>      :tabn<CR>
inoremap <A-x> <Esc>:tabn<CR>
nnoremap <A-z>      :tabp<CR>
inoremap <A-z> <Esc>:tabp<CR>

""" Ctrl+N New Tab
nnoremap <C-n>      :tabnew<CR>
inoremap <C-n> <Esc>:tabnew<CR>

""" Alt+C - Close Current Tab
nnoremap <A-c>      :q<CR>
inoremap <A-c> <Esc>:q<CR>

""" Alt+Q - Close Current Tab Without Saving!
nnoremap <A-q>      :q!<CR>
inoremap <A-q> <Esc>:q!<CR>

""" Shift+Alt+C - Close Other Tabs
nnoremap <A-C>      :tabonly<CR>
inoremap <A-C> <Esc>:tabonly<CR>

""" Alt+[J|K] - Next/Prev Change (diff)
nnoremap <A-j>      ]c
inoremap <A-j> <Esc>]c
nnoremap <A-k>      [c
inoremap <A-k> <Esc>[c

""" Ctrl+S - Save File
nnoremap <C-s>      :w<CR>
inoremap <C-s> <Esc>:w<CR>

""" Ctrl+F2 - Change Background Theme
nnoremap <C-F2> :call ChangeBackgroundTheme()<CR>

""" Ctrl+F3 - Update Font Size
nnoremap <C-F3> :call UpdateFontSize()<CR>

function! ChangeBackgroundTheme()
    if &background == "light"
        set background=dark
    else
        set background=light
    endif
endfunction

function! UpdateFontSize()
    if !has("gui_running")
        return 0
    endif

    if g:nx_font_size == "small"
        let g:nx_font_sz = 9
        let g:nx_font_size = "normal"
    elseif g:nx_font_size == "normal"
        let g:nx_font_sz = 11
        let g:nx_font_size = "large"
    elseif g:nx_font_size == "large"
        let g:nx_font_sz = 13
        let g:nx_font_size = "xlarge"
    elseif g:nx_font_size == "xlarge"
        let g:nx_font_sz = 15
        let g:nx_font_size = "small"
    endif

    if has("gui_gtk")
        let &guifont=g:nx_font_unix . " " . g:nx_font_sz
    elseif has("gui_win32")
        let &guifont=g:nx_font_dos . ":h" . g:nx_font_sz . ":cANSI"
    elseif has("gui_macvim")
        let &guifont=g:nx_font_mac . ":h" . g:nx_font_sz + 1
    endif
endfunction

call UpdateFontSize()

